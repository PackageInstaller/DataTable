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
      " Wait,waitTime=3000; PlayCasterAnimation,animName=skill04; PlayCasterVisible,visible=1; PlayCasterBindEffect,effectID=290510210; PlayAudio,audioID=6280,audioType=1; Wait,waitTime=1900; "
    }
  }
}
return config, "ID", key
