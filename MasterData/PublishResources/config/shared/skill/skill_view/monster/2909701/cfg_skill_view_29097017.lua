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
    0,
    0,
    0,
    {
      " PlaySummonTrap,trapID=2909702; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    29,
    2,
    1,
    500,
    {
      warningCenterPosType = 3,
      warningCenterPosParam = 5,
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
