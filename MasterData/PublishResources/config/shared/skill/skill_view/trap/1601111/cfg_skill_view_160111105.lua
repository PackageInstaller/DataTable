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
      " PlayEntityLegacyAnimation,animNames=eff_1601111_skin_atkchain_gezi_out,trapID=160111110; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
