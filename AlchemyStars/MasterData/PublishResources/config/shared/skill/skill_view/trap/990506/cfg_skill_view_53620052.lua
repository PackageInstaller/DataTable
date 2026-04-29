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
      " PlayCasterBindEffect,effectID=1573; PlayCasterBindEffect,effectID=1574; PlayCasterBindEffect,effectID=290400109, DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=53620031,label=doAgain; PlayTargetAddBuff,buffID=53620032; PlayTargetAddBuff,buffID=53620033; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=700; "
    }
  }
}
return config, "ID", key
