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
      " PlayCasterBindEffect,effectID=3252; PlayAudio,audioID = 8006,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayAllHitBack; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
