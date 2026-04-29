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
      showTimeDelay = 0,
      gridEffectID = 0,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0
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
      " PlayAudio,audioID=7036,audioType=1; Wait,waitTime=1300; "
    }
  }
}
return config, "ID", key
