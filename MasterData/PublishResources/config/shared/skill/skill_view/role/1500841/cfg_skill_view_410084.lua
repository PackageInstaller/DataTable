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
    2,
    0,
    0,
    {
      " PlayCasterBindEffect,effectID=1799; PlayAudio,audioID = 3099,audioType=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=410084,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
