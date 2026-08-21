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
      " PlayCasterAnimation,animName =Skill01; PlayAudio,audioID = 7026,audioType=1; Wait,waitTime=750; PlayCasterVisible,visible=0; PlayTransformation; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
