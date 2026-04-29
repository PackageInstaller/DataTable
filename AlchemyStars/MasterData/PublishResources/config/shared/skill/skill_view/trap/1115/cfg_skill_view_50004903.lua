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
      castEffectID = 681,
      castAnimation = "Skill",
      hitPointDelay = 825,
      onHitAnimation = "Hit",
      hitEffectID = 0,
      castTotalTime = 2467,
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
    {audioID = 5097, audioType = 1}
  }
}
return config, "ID", key
