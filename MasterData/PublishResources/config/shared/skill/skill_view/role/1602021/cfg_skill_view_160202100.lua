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
    100,
    {
      " PlayCasterLegacyAnimation,animNames=eff_1602021_atkult_gezi_end,playOnSuper=1; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=160202100; "
    }
  }
}
return config, "ID", key
