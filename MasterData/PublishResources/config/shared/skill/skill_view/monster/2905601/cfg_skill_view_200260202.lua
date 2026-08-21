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
      " PlayDeleteCasterEffect,effectIDList=200260118; PlayTransformation; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=200260107; PlayCasterBindEffect,effectID=200260116; PlayCasterBindEffect,effectID=200260123; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1400; PlayCasterBindEffect,effectID=200260119; PlayCasterBindEffect,effectID=200260124; "
    }
  }
}
return config, "ID", key
