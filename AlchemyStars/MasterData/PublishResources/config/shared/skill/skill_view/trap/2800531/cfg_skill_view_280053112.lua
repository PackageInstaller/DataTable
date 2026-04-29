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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=28005313,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=28005314,label=doAgain1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain1; "
    }
  }
}
return config, "ID", key
