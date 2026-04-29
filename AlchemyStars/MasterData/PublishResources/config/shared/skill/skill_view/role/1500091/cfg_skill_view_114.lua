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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500091,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    57,
    2,
    1,
    0,
    {
      beginDelay = 0,
      showType = 2,
      showParam = "15000911.prefab",
      endDelay = 0
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    200,
    {
      " PlayAudio,audioID = 2136,audioType=1; "
    }
  },
  {
    4,
    4,
    2,
    2,
    1,
    200,
    {
      effectparam = "368",
      castAnimationName = "AtkUlt",
      finishDelayTime = 2000,
      buffDelayTime = 0
    },
    {"", "1,0"}
  },
  {
    5,
    5,
    31,
    2,
    1,
    4068,
    {
      gridEffectID = 369,
      gridIntervalTime = 33,
      bestConvertTime = 1500,
      finishDelayTime = 1000,
      hasConvert = 1
    }
  },
  {
    6,
    6,
    57,
    2,
    5,
    0,
    {
      beginDelay = 0,
      showType = 2,
      showParam = "1500091.prefab",
      endDelay = 0
    }
  },
  {
    7,
    7,
    23,
    2,
    5,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
