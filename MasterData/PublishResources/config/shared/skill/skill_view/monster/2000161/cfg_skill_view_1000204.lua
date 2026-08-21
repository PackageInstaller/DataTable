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
    2,
    1,
    0,
    0,
    {
      effectparam = "1516,1517",
      castAnimationName = "Skill01",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2040, audioType = 1}
  },
  {
    3,
    3,
    34,
    2,
    1,
    600,
    {
      gridEffectID = 1518,
      gridEffectDelayTime = 266,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    4,
    4,
    43,
    1,
    3,
    0,
    {audioID = 2042, audioType = 1}
  },
  {
    5,
    5,
    45,
    1,
    1,
    0,
    {
      prob = 50,
      tipsList = {
        200016101,
        200016102,
        200016103,
        200016104
      }
    }
  }
}
return config, "ID", key
