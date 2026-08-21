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
      " PlayEffectAtTeamGridAndBindCaster,effectID=290940105,bindCaster=1; PlayEntityLegacyAnimation,animNames=eff_2909401_skill03_in,casterEffectID=290940105; Wait,waitTime=800; PlayEntityLegacyAnimation,animNames=eff_2909401_skill03_loop,casterEffectID=290940105; "
    }
  }
}
return config, "ID", key
