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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600771,waitTime = 2000; "
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
      " PlayCasterLegacyAnimation,animNames=eff_1601481_atkult_gezi01_color; PlayAudio,audioID = 3003,audioType=1; "
    }
  },
  {
    3,
    3,
    30,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      bestEffectTime = 500,
      finishDelayTime = 1000
    }
  }
}
return config, "ID", key
