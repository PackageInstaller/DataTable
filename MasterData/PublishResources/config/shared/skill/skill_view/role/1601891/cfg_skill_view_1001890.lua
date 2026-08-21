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
    91,
    1,
    0,
    0,
    {
      castAnimation = "Atk2",
      castLongAnimation = "Atk2_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 66,
      hitPointDelay = 100,
      longHitPointDelay = 166,
      onHitAnimation = "Hit",
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0
    }
  }
}
return config, "ID", key
