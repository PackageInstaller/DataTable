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
      "Wait,waitTime=50;"
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
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      "Wait,waitTime=800;"
    }
  }
}
return config, "ID", key
