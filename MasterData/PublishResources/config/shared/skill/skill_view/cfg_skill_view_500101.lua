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
    0,
    1,
    0,
    0,
    {
      "Wait,waitTime=500;"
    }
  },
  {
    2,
    2,
    67,
    2,
    1,
    0,
    {
      groupAtkDelay = 300,
      gridEffectID = 1026,
      hitAnim = "Hit"
    }
  }
}
return config, "ID", key
