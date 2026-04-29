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
      " PlayCasterLegacyAnimation,animNames=eff_1601751_atkult_gezi_01_born,playOnSuper=1; Wait,waitTime=1500; PlayCasterLegacyAnimation,animNames=eff_1601751_atkult_gezi_01_idle,playOnSuper=1; "
    }
  }
}
return config, "ID", key
