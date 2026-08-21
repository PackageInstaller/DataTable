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
    nil,
    {
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID=6210,audioType=1; Wait,waitTime=200; "
    }
  },
  {
    2,
    2,
    34,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      gridEffectDelayTime = 500,
      gridIntervalTime = 0,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
