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
      " PlayCasterAnimation,animName = disappear; PlayCasterBindEffect,effectID=3060; Wait,waitTime=300; PlaySuperMaterialAnim,animName=2901001_shader_effects_disappear; Wait,waitTime=500; PlayCasterBindEffect,effectID=3062; "
    }
  }
}
return config, "ID", key
