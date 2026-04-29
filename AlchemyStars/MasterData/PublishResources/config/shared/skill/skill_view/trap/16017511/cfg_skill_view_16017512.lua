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
      " PlayCasterLegacyAnimationByLogicLayer, buffEffectType=4001753, noLayerAnimName=eff_1601751_atkult_gezi_01_small_death,animNameByLayer=eff_1601751_atkult_gezi_01_death|eff_1601751_atkult_gezi_01_Big_death; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1133,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
