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
    66,
    1,
    0,
    0,
    {
      atkAnim = "AtkChain",
      atkGridCenterEffectID = 10791,
      atkShandowCenterEffectID = 10821,
      centerHitDelay = 2050,
      atkGridEffectID = 1078,
      centerDelay = 2150,
      otherGridHitDelay = 800,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 2500
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterBindEffect,effectID=1612; PlayAudio,audioID = 3017,audioType=1; "
    }
  }
}
return config, "ID", key
