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
      " PlayGridDark,darkType=0; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2462,audioType=1; PlayCasterBindEffect,effectID=3581; PlayCasterBindEffect,effectID=3582; Wait,waitTime=3000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1000,
    {
      " DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=16015310; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1000,
    {
      " PlayCasterAddBuff,buffID=3201531; "
    }
  }
}
return config, "ID", key
