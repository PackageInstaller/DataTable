local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=21050272,label=doAgain; PlayTargetAddBuff,buffID=21050273; PlayTargetAddBuff,buffID=21050273; PlayTargetAddBuff,buffID=21150271; PlayTargetAddBuff,buffID=21150272; PlayTargetAddBuff,buffID=21150273; PlayTargetAddBuff,buffID=21150274; PlayTargetAddBuff,buffID=21050277; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=900; "
    }
  }
}
return config, "ID", key
