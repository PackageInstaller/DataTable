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
      " PlayCasterBindEffect,effectID=3661; PlayAudio,audioID = 6198,audioType=1; Wait,waitTime=600; PlayCasterBindEffect,effectID=3662; Wait,waitTime=1400; "
    }
  }
}
return config, "ID", key
