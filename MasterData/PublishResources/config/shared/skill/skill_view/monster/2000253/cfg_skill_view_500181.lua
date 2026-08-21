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
      castEffectID = 622,
      castAnimationName = "Atk",
      hitDelayTime = 1050,
      trajectoryType = 1,
      trajectoryEffectID = 620,
      trajectoryTime = 50,
      targetEffectID = 621,
      hpDelay = 0,
      hitAnimationName = "Hit",
      hitEffectID = 621,
      finishDelayTime = 500
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5086, audioType = 1}
  }
}
return config, "ID", key
