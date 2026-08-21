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
      " Wait,waitTime=2300; PlayCasterAnimation,animName=skill04; PlayCasterBindEffect,effectID=290510118; PlayAudio,audioID=6281,audioType=1; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
