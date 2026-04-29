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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1400081,waitTime = 2000;"
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
      effectparam = "65",
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
    0,
    {audioID = 2112, audioType = 1}
  },
  {
    4,
    4,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 67
      }
    }
  },
  {
    5,
    5,
    18,
    2,
    1,
    2860,
    {
      paramArray = "66",
      lastTime = 3000,
      gridEffectDelayTime = 1000
    }
  }
}
return config, "ID", key
