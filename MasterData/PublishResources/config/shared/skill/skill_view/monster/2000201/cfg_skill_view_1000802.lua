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
    1,
    0,
    0,
    {
      castEffectID = 0,
      castAnimationStr = "AtkL,AtkR",
      blurDelay = {300, 250},
      blurEffectId = "1590,1591",
      hitPointDelay = {50, 50},
      onHitAnimation = "Hit",
      hitEffectID = {1592, 1593},
      overDelay = {1150, 1367},
      audioID = {2043, 2043},
      audioDelay = {0, 0}
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "Wait,waitTime=1500;"
    }
  }
}
return config, "ID", key
