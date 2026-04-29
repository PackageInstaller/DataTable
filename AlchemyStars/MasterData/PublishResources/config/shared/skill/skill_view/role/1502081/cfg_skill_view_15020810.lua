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
      " PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID=150208108; PlayAudio,audioID = 2680,audioType=1; Wait,waitTime=2500; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    900,
    {
      "PlayMultiTraction; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
