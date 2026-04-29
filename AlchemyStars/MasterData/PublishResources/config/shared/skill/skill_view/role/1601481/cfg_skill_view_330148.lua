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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; "
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
      " PlayCasterAddBuff,buffEffectType =4301481; PlayCasterAddBuff,buffEffectType =4361481; PlayCasterAddBuff,buffEffectType =4301482; PlayCasterAddBuff,buffEffectType =4331481; PlayCasterAddBuff,buffEffectType =4361482; "
    }
  }
}
return config, "ID", key
