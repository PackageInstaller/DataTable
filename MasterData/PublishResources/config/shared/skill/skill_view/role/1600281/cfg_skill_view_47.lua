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
    1,
    1,
    0,
    0,
    {
      castEffectID = 219,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 200,
      longAtkEffectDelay = 333,
      hitPointDelay = 233,
      longHitPointDelay = 400,
      onHitAnimation = "Hit",
      hitEffectID = 0,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    100,
    {audioID = 2200, audioType = 1}
  }
}
return config, "ID", key
