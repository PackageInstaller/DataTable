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
      "PlayDeleteWaringArea;"
    }
  },
  {
    2,
    2,
    29,
    1,
    1,
    0,
    {
      warningCenterPosType = 5,
      warningCenterPosParam = 2,
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
