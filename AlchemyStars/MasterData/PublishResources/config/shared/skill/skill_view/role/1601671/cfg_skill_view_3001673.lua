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
      " Wait,waitTime=2500; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType =4001673,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; PlayIncreaseSan; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
