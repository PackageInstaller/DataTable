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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1400411,waitTime = 2000;"
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
      "PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=595; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2127, audioType = 1}
  },
  {
    4,
    4,
    31,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      gridIntervalTime = 0,
      bestConvertTime = 1666,
      finishDelayTime = 3000,
      hasConvert = 1,
      gridEffectDirection = "Up"
    }
  },
  {
    5,
    5,
    23,
    2,
    4,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
