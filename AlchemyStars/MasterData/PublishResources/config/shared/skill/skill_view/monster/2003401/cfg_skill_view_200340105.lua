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
      " PlayEntityLegacyAnimation,animNames=eff_2003401_idle01_out_mian,casterEffectID=200340101; PlayEntityLegacyAnimation,animNames=eff_2003401_idle02_out_mian,casterEffectID=200340102; Wait,waitTime=700; "
    }
  }
}
return config, "ID", key
