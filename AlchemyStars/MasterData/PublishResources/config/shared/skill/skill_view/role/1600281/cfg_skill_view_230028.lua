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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 1854; PlayCasterBindEffect,effectID = 1855; PlayCasterBindEffect,effectID = 1856; Wait,waitTime = 466; PlayCasterVisible,visible=0; Wait,waitTime = 2800; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkChain1; Wait,waitTime = 1000; "
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2219, audioType = 1}
  },
  {
    3,
    3,
    31,
    1,
    1,
    2500,
    {
      gridEffectID = 1857,
      gridIntervalTime = 100,
      finishDelayTime = 500,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
