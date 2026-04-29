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
      " PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName =Death; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=888403571,label=doAgain; PlayTargetAddBuff,buffID=888403572; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
