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
      " PlayCasterAnimation,animName=Death; PlayCasterBindEffect,effectID=3127; PlayCasterMaterialAnim,animName=eff_2900681_die; "
    }
  }
}
return config, "ID", key
