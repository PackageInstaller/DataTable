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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4201323,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=700; PlayTargetBindEffect,effectID=3185; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
