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
      " PlaySuperMaterialAnim,animName=2901001_shader_effects_appear; PlayCasterBindEffect,effectID=3061; Wait,waitTime=300; PlayCasterAnimation,animName = appear; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    38,
    1,
    0,
    0,
    {
      effectIDList = {3062}
    }
  }
}
return config, "ID", key
