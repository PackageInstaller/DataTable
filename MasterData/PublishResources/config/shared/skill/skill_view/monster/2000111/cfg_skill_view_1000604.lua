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
      castEffectID = 1552,
      castAnimationName = "Atk",
      hitDelayTime = 820,
      hitAnimationName = "Hit",
      hitEffectID = 1553,
      finishDelayTime = 500
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2035, audioType = 1}
  }
}
return config, "ID", key
