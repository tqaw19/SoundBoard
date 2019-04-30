//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Alejandro Quesada on 30/04/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupRecorder()

        // Do any additional setup after loading the view.
    }
    func setupRecorder(){
        do{
            //Creando una sesión de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Creando una dirección para el archivo de audio.
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("***************************")
            print(audioURL)
            print("***************************")
            
            //Crear opciones para el grabador de audio
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            //Crear el objeto de grabación de audio
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError{
            print(error)
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder!.isRecording{
            //Detener la grabación
            audioRecorder?.stop()
            //Cambiar el texto del boton grabar
            recordButton.setTitle("Record", for: .normal)
        }
        else{
            //Empezar a grabar
            audioRecorder?.record()
            //Cambiar el título del boton a detener
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
