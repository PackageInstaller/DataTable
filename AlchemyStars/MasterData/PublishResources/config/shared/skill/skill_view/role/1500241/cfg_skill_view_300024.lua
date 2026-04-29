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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkUlt; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayAudio,audioID = 2242,audioType=1; DataSelectResult,effectType=79,index=1; PlaySummonTrap,trapID=3000241; PlaySummonTrap,trapID=3300241; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffEffectType=15002410; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
