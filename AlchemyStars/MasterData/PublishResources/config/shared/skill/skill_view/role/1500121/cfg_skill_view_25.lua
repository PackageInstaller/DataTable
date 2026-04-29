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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1500121,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    2,
    2,
    1,
    0,
    {
      effectparam = "97",
      castAnimationName = "AtkUlt",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    800,
    {audioID = 2139, audioType = 1}
  },
  {
    4,
    4,
    32,
    1,
    2,
    3000,
    {
      effectID = 99,
      effectDirection = "Up",
      finishDelayTime = 1000,
      effectFlyOneGridMs = 160,
      effectHit = -1,
      hitAnimationName = "Hit",
      hasDamage = 1
    }
  },
  {
    5,
    5,
    31,
    1,
    2,
    3150,
    {
      gridEffectID = 100,
      gridIntervalTime = 85,
      bestConvertTime = 50,
      finishDelayTime = 1000,
      hasConvert = 1,
      hitAnimationName = "Hit",
      hitEffectID = -1
    }
  }
}
return config, "ID", key
