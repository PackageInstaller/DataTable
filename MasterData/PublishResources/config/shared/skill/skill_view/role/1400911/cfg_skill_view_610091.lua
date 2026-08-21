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
      " PlayCasterBindEffect,effectID =1771; PlayAudio,audioID = 3084,audioType=1; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    500,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4100911,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    500,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4100912,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
