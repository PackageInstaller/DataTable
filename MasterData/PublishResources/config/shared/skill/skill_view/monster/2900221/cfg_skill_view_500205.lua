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
      castAnimationStr = "Atk01L,Atk01R",
      blurDelay = {0, 0},
      blurEffectId = "946,947",
      hitPointDelay = {400, 400},
      onHitAnimation = "Hit",
      hitEffectID = {948, 948},
      overDelay = {933, 933}
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6047, audioType = 1}
  }
}
return config, "ID", key
