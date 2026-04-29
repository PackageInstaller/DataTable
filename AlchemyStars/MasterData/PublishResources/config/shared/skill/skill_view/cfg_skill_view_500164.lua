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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=Finish; PlayFlyEffectCasterToTarget,flyEffectID=1021,flyTime=200,offsetx=0,offsety=0.7,offsetz=0,flyTrace=1,label=doAgain; Wait,waitTime=200; PlayTargetAddBuff,buffID=20021; PlayTargetBuffEffect,effectID=1022; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=500,label=Finish; "
    }
  }
}
return config, "ID", key
