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
    29,
    1,
    0,
    0,
    {
      warningCenterPosType = 4,
      warningTextEffectID = 339,
      areaRes = "",
      hasDeadWarning = true
    }
  }
}
return config, "ID", key
