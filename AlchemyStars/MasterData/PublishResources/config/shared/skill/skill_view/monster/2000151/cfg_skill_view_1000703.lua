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
      blurDelay = {0, 0},
      blurEffectId = "1570,1571",
      hitPointDelay = {462, 462},
      onHitAnimation = "Hit",
      hitEffectID = {1572, 1572},
      overDelay = {700, 700}
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    350,
    {audioID = 2031, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    350,
    {
      "Wait,waitTime=900;"
    }
  }
}
return config, "ID", key
