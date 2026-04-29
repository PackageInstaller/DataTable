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
      " PlayCasterLegacyAnimation,animNames=eff_1601751_atkult_gezi_01_small_born; Wait,waitTime=100; PlayCasterLegacyAnimation,animNames=eff_1601751_atkult_gezi_01_small_idle; "
    }
  }
}
return config, "ID", key
