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
    38,
    1,
    0,
    0,
    {
      effectIDList = {1573, 1574}
    }
  },
  {
    2,
    2,
    2,
    1,
    1,
    0,
    {
      effectparam = "1575,1576,1577",
      finishDelayTime = 0,
      buffDelayTime = 2432
    }
  },
  {
    3,
    3,
    43,
    1,
    1,
    0,
    {audioID = 2032, audioType = 1}
  },
  {
    4,
    4,
    26,
    1,
    1,
    0,
    {
      castAnimationName = "Skill",
      hitDelayTime = 2432,
      targetEffectID = 0,
      hitAnimationName = "Hit",
      finishDelayTime = 1000,
      hpDelay = 0
    }
  }
}
return config, "ID", key
