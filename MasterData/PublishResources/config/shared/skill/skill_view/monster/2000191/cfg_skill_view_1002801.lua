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
      castEffectID = 148,
      castAnimation = "Atk",
      hitPointDelay = 266,
      onHitAnimation = "Hit",
      hitEffectID = 149,
      castTotalTime = 500,
      hpDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    33,
    {audioID = 2019, audioType = 1}
  }
}
return config, "ID", key
