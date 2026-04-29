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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=646; Wait,waitTime=1500; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5030, audioType = 1}
  }
}
return config, "ID", key
