local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterAnimation,animName =Victory; PlayCasterBindEffect,effectID=870; Wait,waitTime=4000; "
    },
    {"", "0,-1"}
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5087, audioType = 1}
  }
}
return config, "ID", key
