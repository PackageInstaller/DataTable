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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; PlayCasterMaterialAnim,animName=PARAM.animName; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=200260107; PlayCasterBindEffect,effectID=200260116; Wait,waitTime=400; PlayCasterBindEffect,effectID=200260123; Wait,waitTime=800; PlayCasterBindEffect,effectID=200260119; Wait,waitTime=300; PlayCasterBindEffect,effectID=200260124; PlayCasterHUDVisible,visible=1; "
    }
  }
}
return config, "ID", key
