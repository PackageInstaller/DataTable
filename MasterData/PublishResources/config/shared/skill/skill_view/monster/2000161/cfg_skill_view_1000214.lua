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
      castEffectID = 1513,
      castAnimation = "Atk",
      hitPointDelay = 200,
      hitEffectID = 1514,
      hitPointDelay = 200,
      onHitAnimation = "Hit",
      castTotalTime = 1667,
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
    {audioID = 2039, audioType = 1}
  }
}
return config, "ID", key
