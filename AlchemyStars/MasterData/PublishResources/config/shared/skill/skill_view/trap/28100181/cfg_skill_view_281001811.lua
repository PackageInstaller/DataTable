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
      castEffectID = 169,
      castAnimationName = "Atk",
      hitDelayTime = 500,
      trajectoryType = 2,
      trajectoryEffectID = 171,
      trajectoryTime = 150,
      hitAnimationName = "Hit",
      hitEffectID = 170,
      finishDelayTime = 300
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 5103, audioType = 1}
  }
}
return config, "ID", key
