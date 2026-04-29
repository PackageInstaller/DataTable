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
      " PlayCasterBindEffect,effectID=290950106; PlayEntityLegacyAnimation,animNames=effanim_2909501_birth_main2_out,casterEffectID=290950106; PlayCasterAnimation,animName = Death2; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
