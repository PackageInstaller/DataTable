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
      " PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2439,audioType=1; PlayCasterBindEffect,effectID=3502; PlaySummonTrap,trapID=16014811; PlaySummonTrap,trapID=16014812; PlaySummonTrap,trapID=16014813; PlayMoveTrap; Wait,waitTime=1800; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayAddBuffView,buffEffectType=420148; "
    }
  }
}
return config, "ID", key
