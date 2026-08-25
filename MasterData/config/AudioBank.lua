local System = require("System.System")
local readonly = System.readonly
local AudioBank = readonly({
  Sound_AVG_Chapter_1 = {
    BankID = "Sound_AVG_Chapter_1",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "SoundEffct"
  },
  Sound_AVG_Chapter_2 = {
    BankID = "Sound_AVG_Chapter_2",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "SoundEffct"
  },
  Sound_AVG_Chapter_3 = {
    BankID = "Sound_AVG_Chapter_3",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "SoundEffct"
  },
  Sound_AVG_Chapter_4 = {
    BankID = "Sound_AVG_Chapter_4",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "SoundEffct"
  },
  Sound_AVG_Chapter_5 = {
    BankID = "Sound_AVG_Chapter_5",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "SoundEffct"
  },
  Sound_AVG_Chapter_6 = {
    BankID = "Sound_AVG_Chapter_6",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "SoundEffct"
  },
  Sound_AVG_Common = {
    BankID = "Sound_AVG_Common",
    LoadTime = {"EnterAvg"},
    UnloadTime = {"ExitAvg"},
    BankType = "Bgm"
  },
  Sound_Chr_Ingame_Common = {
    BankID = "Sound_Chr_Ingame_Common",
    LoadTime = {"EnterCopy"},
    UnloadTime = {
      "EnterMainPanel"
    },
    BankType = "SoundEffct"
  },
  Mus = {
    BankID = "Mus",
    LoadTime = {"EnterGame"},
    BankType = "Bgm"
  },
  SFX_Interface_Main_UI = {
    BankID = "SFX_Interface_Main_UI",
    LoadTime = {
      "EnterMainPanel"
    },
    UnloadTime = {"EnterAvg", "EnterCopy"},
    BankType = "SoundEffct"
  },
  SFX_Ingame_Common = {
    BankID = "SFX_Ingame_Common",
    LoadTime = {"EnterCopy"},
    UnloadTime = {
      "EnterMainPanel"
    },
    BankType = "SoundEffct"
  },
  SFX_Ingame_UI = {
    BankID = "SFX_Ingame_UI",
    LoadTime = {"EnterCopy"},
    UnloadTime = {
      "EnterMainPanel"
    },
    BankType = "SoundEffct"
  },
  VO_Chr_Outgame = {
    BankID = "VO_Chr_Outgame",
    LoadTime = {
      "EnterMainPanel"
    },
    UnloadTime = {"EnterAvg", "EnterCopy"},
    BankType = "SoundEffct"
  },
  Globle_Common = {
    BankID = "Globle_Common",
    LoadTime = {"EnterGame"},
    BankType = "SoundEffct"
  }
})
return AudioBank
