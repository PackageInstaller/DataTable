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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=667; "
    }
  },
  {
    2,
    2,
    34,
    2,
    1,
    1000,
    {
      gridEffectID = 668,
      gridEffectDelayTime = 0,
      gridIntervalTime = 100,
      showTimeDelay = 600
    }
  },
  {
    3,
    3,
    43,
    1,
    0,
    0,
    {audioID = 5085, audioType = 1}
  }
}
return config, "ID", key
