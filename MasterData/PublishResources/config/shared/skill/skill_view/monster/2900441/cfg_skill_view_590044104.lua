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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=PARAM.effectID1; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6002, audioType = 1}
  },
  {
    3,
    3,
    23,
    1,
    1,
    800,
    {showTime = 0}
  }
}
return config, "ID", key
