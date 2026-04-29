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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600251,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    43,
    2,
    1,
    0,
    {audioID = 2025, audioType = 1}
  },
  {
    3,
    3,
    40,
    2,
    1,
    0,
    {
      hitAnimationName = "Hit",
      hitFirstEffectID = 140,
      hitRepeatEffectID = 141,
      hideAnimationName = "AtkUlt",
      showAnimationName = "AtkUlt_Done",
      trainEffectDelay = 100,
      trainEffectID = 139,
      boardCenterPos = {5, 5},
      hideList = {
        [1] = {
          hideEffectDelayTime = 360,
          hideEffectID = 143,
          hideAnimationDelayTime = 740
        },
        [2] = {hideEffectDelayTime = 0, hideAnimationDelayTime = 100}
      },
      showList = {
        [1] = {showEffectDelayTime = 1500},
        [2] = {
          showEffectDelayTime = 1500,
          showEffectID = 142,
          showAnimationDelayTime = 330
        }
      },
      finishDelayTime = 1000,
      multiMonsterHitDelayTime = 100,
      casterInTrainHigh = 0,
      hitBackSpeed = 5
    }
  },
  {
    4,
    4,
    79,
    1,
    3,
    2600,
    {
      gridEffectID = 144,
      gridIntervalTime = 100,
      bestConvertTime = 200,
      finishDalyTime = 0
    }
  }
}
return config, "ID", key
