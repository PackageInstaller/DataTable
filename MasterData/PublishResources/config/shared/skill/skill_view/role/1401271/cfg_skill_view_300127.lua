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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1300581,waitTime =2000;"
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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2793; PlayAudio,audioID = 2310,audioType=1; PlaySummonTrap,trapID=14012711; PlaySummonTrap,trapID=14012712; PlaySummonTrap,trapID=14; Wait,waitTime=3333; "
    }
  }
}
return config, "ID", key
