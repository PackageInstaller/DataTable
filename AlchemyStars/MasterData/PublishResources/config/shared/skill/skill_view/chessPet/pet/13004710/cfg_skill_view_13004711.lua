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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 2097,audioType=1; PlayCasterBindEffect,effectID =471; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    36,
    1,
    1,
    1180,
    {
      gridEffectID = 0,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
