//
//  ViewController.swift
//  ReadWritePlistTutorial
//
//  Created by rebeloper on 1/31/15.
//  Copyright (c) 2015 Rebeloper. All rights reserved.
//

import UIKit

// MARK: == GameData.plist Keys ==
let BedroomFloorKey = "BedroomFloor"
let BedroomWallKey = "BedroomWall"
// MARK: -

class ViewController: UIViewController {
  
  // MARK: == Variables ==
  var bedroomFloorID: AnyObject = 101
  var bedroomWallID: AnyObject = 101

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    loadGameData()
  }

  @IBAction func saveButtonTapped(sender: AnyObject) {
    //change bedroomFloorID variable value
    bedroomFloorID = 999
    //save the plist with the changes
    saveGameData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func loadGameData() {
    
    // getting path to GameData.plist
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
    let documentsDirectory = paths[0] as String
    let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
    
    let fileManager = NSFileManager.defaultManager()
    
    //check if file exists
    if(!fileManager.fileExistsAtPath(path)) {
      // If it doesn't, copy it from the default file in the Bundle
      if let bundlePath = NSBundle.mainBundle().pathForResource("GameData", ofType: "plist") {
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
        println("Bundle GameData.plist file is --> \(resultDictionary?.description)")
        
        fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
        println("copy")
      } else {
        println("GameData.plist not found. Please, make sure it is part of the bundle.")
      }
    } else {
      println("GameData.plist already exits at path.")
      // use this to delete file from documents directory
      //fileManager.removeItemAtPath(path, error: nil)
    }
    
    let resultDictionary = NSMutableDictionary(contentsOfFile: path)
    println("Loaded GameData.plist file is --> \(resultDictionary?.description)")
    
    var myDict = NSDictionary(contentsOfFile: path)
    
    if let dict = myDict {
      //loading values
      bedroomFloorID = dict.objectForKey(BedroomFloorKey)!
      bedroomWallID = dict.objectForKey(BedroomWallKey)!
      //...
    } else {
      println("WARNING: Couldn't create dictionary from GameData.plist! Default values will be used!")
    }
  }
  
  func saveGameData() {
    
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
    let documentsDirectory = paths.objectAtIndex(0) as NSString
    let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
    
    var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
    //saving values
    dict.setObject(bedroomFloorID, forKey: BedroomFloorKey)
    dict.setObject(bedroomWallID, forKey: BedroomWallKey)
    //...
    
    //writing to GameData.plist
    dict.writeToFile(path, atomically: false)
    
    let resultDictionary = NSMutableDictionary(contentsOfFile: path)
    println("Saved GameData.plist file is --> \(resultDictionary?.description)")
    
  }

}

