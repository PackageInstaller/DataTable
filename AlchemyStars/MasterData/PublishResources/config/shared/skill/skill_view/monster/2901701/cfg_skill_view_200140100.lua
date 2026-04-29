local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=2001403,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; PlayCasterSuicide; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      "PlayIncreaseSan;"
    }
  }
}
return config, "ID", key
