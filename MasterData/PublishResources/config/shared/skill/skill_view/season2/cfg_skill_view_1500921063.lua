local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
}
local config = {
  {
    1,
    1,
    0,
    2,
    0,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1739; PlayAudio,audioID = 2211,audioType=1; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    31,
    2,
    1,
    1000,
    {
      gridEffectID = 1740,
      gridIntervalTime = 0,
      bestConvertTime = 2200,
      finishDelayTime = 1000,
      hasConvert = 1
    }
  },
  {
    3,
    3,
    23,
    2,
    2,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
