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
      " PlayCasterAnimation,animName = Death; PlayCasterMaterialAnim,animName=eff_2910001_death_main; PlaySelectObjAnimation,objName=eff_2910002_idle_Dummy_2910002,animName=eff_2910001_idle_death; "
    }
  }
}
return config, "ID", key
