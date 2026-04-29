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
    47,
    0,
    0,
    0,
    {
      castEffectID = 0,
      castAnimationStr = "Atk02L,Atk02R",
      blurDelay = {0, 0},
      blurEffectId = "951,950",
      hitPointDelay = {500, 500},
      onHitAnimation = "Hit",
      hitEffectID = {949, 949},
      overDelay = {833, 833}
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6048, audioType = 1}
  }
}
return config, "ID", key
