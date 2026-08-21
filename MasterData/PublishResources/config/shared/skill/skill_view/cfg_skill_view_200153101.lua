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
    30,
    1,
    0,
    0,
    {
      gridEffectID = 3892,
      bestEffectTime = 0,
      finishDelayTime = 0
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
      " PlaySummonTrap,trapID=14; "
    }
  }
}
return config, "ID", key
