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
      " PlayCasterBindEffect,effectID =2424; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayTeamBindEffect,effectID=2422,mode=2; "
    }
  }
}
return config, "ID", key
