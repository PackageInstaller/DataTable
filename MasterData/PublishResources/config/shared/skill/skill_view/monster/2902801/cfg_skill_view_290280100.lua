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
      " PlayCasterAnimation,animName = birth; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterBindEffect,effectID=290280119; PlayAudio,audioID = 6299,audioType=1; Wait,waitTime=2700; "
    }
  }
}
return config, "ID", key
