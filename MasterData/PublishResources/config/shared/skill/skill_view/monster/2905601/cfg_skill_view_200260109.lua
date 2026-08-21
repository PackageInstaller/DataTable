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
      " PlayCasterAnimation,animName=Death; PlayCasterBindEffect,effectID=200260108; PlayCasterBindEffect,effectID=200260120; PlayCasterMaterialAnim,animName=PARAM.animName; PlayCasterHUDVisible,visible=0; Wait,waitTime=3200; PlayCasterVisible,visible=0; "
    }
  }
}
return config, "ID", key
