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
      " PlayCasterVisible,visible=0; Wait,waitTime=1; PlayCasterVisible,visible=1; PlayCasterMaterialAnim,animName=eff_15014911_birth; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
