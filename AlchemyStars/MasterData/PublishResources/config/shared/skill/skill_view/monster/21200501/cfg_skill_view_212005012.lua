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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2087,audioType=1; PlayCasterBindEffect,effectID = 1037; PlayCasterBindEffect,effectID = 1038; Wait,waitTime = 3600; "
    }
  },
  {
    2,
    2,
    31,
    1,
    1,
    1900,
    {
      gridEffectID = 1039,
      gridIntervalTime = 120,
      finishDelayTime = 1000,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 1040
    }
  }
}
return config, "ID", key
