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
      "PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3897; PlayAudio,audioID = 2530; PlayLevelTrapCommonSummon,destroyEffectID=3902,maxLevelCamEffectID=3899,summonDelay=401,lvUpEffectID=3898,destroyDelay=400,maxLevelAudioID=2531; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
