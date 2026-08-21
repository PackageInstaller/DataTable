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
    71,
    1,
    0,
    0,
    {gridEffectID = 502, bestEffectTime = 150}
  }
}
return config, "ID", key
