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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName = Birth; PlayCasterBindEffect,effectID=682; Wait,waitTime=1000; PlayCasterHUDVisible,visible=1; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 5098, audioType = 1}
  },
  {
    3,
    3,
    23,
    1,
    1,
    1300,
    {showTime = 200}
  }
}
return config, "ID", key
