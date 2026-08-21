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
      " PlayCasterAnimation,animName=Death; PlayAudio,audioID =6067,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=2100; "
    }
  }
}
return config, "ID", key
