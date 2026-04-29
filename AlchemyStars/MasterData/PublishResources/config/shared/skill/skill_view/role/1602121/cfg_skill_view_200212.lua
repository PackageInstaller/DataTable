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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 160212102,audioType=1; PlayCasterBindEffect,effectID=160212103; Wait,waitTime=2750; "
    }
  },
  {
    2,
    2,
    31,
    1,
    1,
    1000,
    {
      gridEffectID = 160212104,
      gridIntervalTime = 100,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 160212105,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
