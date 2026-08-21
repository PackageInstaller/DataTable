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
      " PlayLevelTrapCommonSummon,destroyEffectID=3902,maxLevelCamEffectID=3899,lvUpEffectID=3898,maxLevelAudioID=2531; PlayAudio,audioID = 2530; "
    }
  }
}
return config, "ID", key
