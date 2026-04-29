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
    34,
    1,
    0,
    0,
    {
      gridEffectID = 0,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterVisible,visible=0; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayCasterHUDVisible,visible=0; "
    }
  }
}
return config, "ID", key
