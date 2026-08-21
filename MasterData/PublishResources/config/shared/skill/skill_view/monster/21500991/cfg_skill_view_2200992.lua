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
      " PlayCasterBindEffect,effectID =2371; PlayAudio,audioID = 2259; "
    }
  },
  {
    2,
    2,
    66,
    1,
    1,
    0,
    {
      atkAnim = "AtkChain",
      atkGridCenterEffectID = 2372,
      atkGridRandomEffect = {2370},
      centerHitDelay = 1050,
      centerDelay = 1050,
      otherGridHitDelay = 0,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 2500,
      distanceDelay = 50
    }
  }
}
return config, "ID", key
