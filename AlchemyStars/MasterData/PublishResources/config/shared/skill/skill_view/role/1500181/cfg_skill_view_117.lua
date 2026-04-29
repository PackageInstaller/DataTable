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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500181,waitTime = 2000;"
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
      "PlayAudio,audioID = 2145,audioType=1;"
    }
  },
  {
    3,
    3,
    26,
    2,
    1,
    0,
    {
      castEffectID = 394,
      castAnimationName = "AtkUlt",
      hitDelayTime = 3933,
      targetEffectID = 0,
      hpDelay = 0,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      finishDelayTime = 5000,
      clearBodyNow = 0
    },
    {"", "0,-1"}
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " PlayCameraEffect,effectID=393; Wait,waitTime=10000; "
    }
  }
}
return config, "ID", key
