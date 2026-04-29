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
    38,
    2,
    0,
    0,
    {
      effectIDList = {833}
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
      " PlayCasterAnimation,animName = DashFail; PlayAudio,audioID = 5031,audioType=1; PlayCasterBindEffect,effectID=744; Wait,waitTime=3000; "
    }
  }
}
return config, "ID", key
