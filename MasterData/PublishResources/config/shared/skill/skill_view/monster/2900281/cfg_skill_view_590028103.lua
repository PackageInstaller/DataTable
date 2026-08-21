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
      " PlayCasterAnimation,animName =Skill01; PlayAudio,audioID = 5007,audioType=1; PlayCasterBindEffect,effectID=875; "
    }
  },
  {
    2,
    2,
    31,
    1,
    1,
    1200,
    {
      gridEffectID = 876,
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
