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
      " PlayCasterAnimation,animName = Idle; PlayAudio,audioID = 6010,audioType=1; PlayCasterBindEffect,effectID=1269; Wait,waitTime=1000; PlayCasterBindEffect,effectID=1268; "
    }
  }
}
return config, "ID", key
