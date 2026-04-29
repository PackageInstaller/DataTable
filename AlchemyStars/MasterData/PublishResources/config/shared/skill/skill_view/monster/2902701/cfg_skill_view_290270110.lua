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
      " PlayCasterBindEffect,effectID=2780; PlayAudio,audioID=6090,audioType=1; Wait,waitTime=1000; PlayCasterAnimation,animName=Death; Wait,waitTime=2650; PlayCasterVisible,visible=0; Wait,waitTime=2350; "
    }
  }
}
return config, "ID", key
