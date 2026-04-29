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
      " DataSelectBuff,buffIndex = 1; PlayCasterBindEffect,effectID=1027,effectDir=1; Wait,waitTime=1000; PlayTargetAddBuff,buffID=10011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
