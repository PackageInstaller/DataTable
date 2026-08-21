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
    23,
    1,
    0,
    0,
    {showTimeDelay = 0}
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      "PlayCasterVisible,visible=0;"
    }
  }
}
return config, "ID", key
