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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2418,audioType=1; PlayCasterBindEffect,effectID=3365; PlayCasterBindEffect,effectID=3366; Wait,waitTime=2500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=16014311; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
