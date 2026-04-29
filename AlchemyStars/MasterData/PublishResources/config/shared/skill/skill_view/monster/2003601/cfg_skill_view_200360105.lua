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
      " PlayCasterAnimation,animName = Die; Wait,waitTime=500; PlayCasterHUDVisible,visible=0; PlayCasterVisible,visible=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=200360104; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
