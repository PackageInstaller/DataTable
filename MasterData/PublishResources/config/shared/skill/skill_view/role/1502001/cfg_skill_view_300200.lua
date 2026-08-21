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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1300741,waitTime = 2000;"
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
      " PlayAudio,audioID = 2641,audioType=1; PlayCasterBindEffect,effectID=150200111; Wait,waitTime=4000; "
    }
  },
  {
    3,
    3,
    106,
    2,
    1,
    0,
    {
      casterAction = "AtkUlt",
      casterEffectID = 150200108,
      playTractionDelayMs = 5200,
      tractionCenterEffectDelayMs = 3500,
      tractionCenterEffectID = 150200113,
      tractionChaseEffectID = 150200109,
      tractionChaseEffectTimeMs = 1200,
      tractionPushEffectID = 150200112,
      tractionPushEffectHoldTimeMs = 500,
      tractionPushEffectMoveTimeMs = 100,
      tractionBoomEffectID = 150200110,
      tractionTargetEffectID = 0,
      tractionMoveTimeMs = 100,
      beHitAnimation = "Hit",
      beHitEffectID = 0,
      finalWaitTimeMs = 1000
    }
  }
}
return config, "ID", key
