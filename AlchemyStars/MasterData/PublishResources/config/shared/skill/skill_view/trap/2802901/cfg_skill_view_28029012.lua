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
    36,
    1,
    0,
    0,
    {
      gridEffectID = 280290104,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 7041, audioType = 1}
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
