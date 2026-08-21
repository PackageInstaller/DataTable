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
      castEffectID = 1473,
      castAnimation = "Atk",
      hitPointDelay = 300,
      onHitAnimation = "Hit",
      hitEffectID = 1474,
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
    0,
    {audioID = 2028, audioType = 1}
  }
}
return config, "ID", key
