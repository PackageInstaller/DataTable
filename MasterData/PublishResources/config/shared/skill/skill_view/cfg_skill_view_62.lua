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
      " PlayCasterAnimation,animName =Atk; PlayCasterBindEffect,effectID=401; PlayAudio,audioID = 5102,audioType=1; "
    }
  },
  {
    2,
    2,
    36,
    2,
    1,
    0,
    {
      gridEffectID = 402,
      gridEffectDelayTime = 1000,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
