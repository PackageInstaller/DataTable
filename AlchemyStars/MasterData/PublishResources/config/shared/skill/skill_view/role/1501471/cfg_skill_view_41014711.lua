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
      " Wait,waitTime=200; PlayChangePetTeamOrder; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=3,label=doAgain; PlayTargetAddBuff,buffEffectType =4101470; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    },
    {"", "1,-1"}
  }
}
return config, "ID", key
