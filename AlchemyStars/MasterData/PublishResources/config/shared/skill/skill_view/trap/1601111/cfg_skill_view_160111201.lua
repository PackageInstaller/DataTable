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
      " PlayCasterLegacyAnimation,animNames=eff_1601111_skin_atkchain_biaoji_in|eff_1601111_skin_atkchain_biaoji_loop; "
    }
  }
}
return config, "ID", key
