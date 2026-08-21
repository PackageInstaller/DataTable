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
      " PlayCasterAnimation,animName =Escape; Wait,waitTime=700; PlayAudio,audioID = 5079,audioType=1; PlayCasterBindEffect,effectID=766; Wait,waitTime=5300; "
    }
  }
}
return config, "ID", key
