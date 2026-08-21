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
      " PlayAudio,audioID = 290580104,audioType=1; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayCasterBindEffect,effectID=290580101; Wait,waitTime=2000; PlayAllHitBack; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
