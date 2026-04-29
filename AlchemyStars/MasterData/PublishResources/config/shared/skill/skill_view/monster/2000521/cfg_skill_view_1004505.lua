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
    800,
    {showTime = 0}
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 7019, audioType = 1}
  }
}
return config, "ID", key
