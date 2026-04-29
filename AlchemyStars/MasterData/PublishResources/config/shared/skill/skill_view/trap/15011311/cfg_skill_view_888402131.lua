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
    26,
    1,
    0,
    0,
    {
      hitDelayTime = 50,
      targetEffectID = 0,
      hpDelay = 0,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      finishDelayTime = 0,
      clearBodyNow = 0
    }
  }
}
return config, "ID", key
