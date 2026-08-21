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
      " PlayCasterAnimation,animName =Skill02; PlayCasterBindEffect,effectID=2418; Wait,waitTime=6000; "
    }
  },
  {
    2,
    2,
    38,
    1,
    0,
    2000,
    {
      effectIDList = {
        2411,
        2412,
        2413,
        2414,
        2415
      }
    }
  },
  {
    3,
    3,
    43,
    1,
    0,
    0,
    {audioID = 6079, audioType = 1}
  }
}
return config, "ID", key
