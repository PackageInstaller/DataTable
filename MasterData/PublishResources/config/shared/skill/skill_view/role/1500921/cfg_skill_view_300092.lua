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
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1500921,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1739; PlayAudio,audioID = 2211,audioType=1; Wait,waitTime=4000; "
    }
  },
  {
    3,
    3,
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
    4,
    4,
    23,
    2,
    3,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
