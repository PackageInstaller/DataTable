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
      " PlayCasterBindEffect,effectID=3408; PlayAudio,audioID=6177,audioType=1; Wait,waitTime=400; PlayCasterAnimation,animName=Birth; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterMaterialAnim,animName=eff_2902101_birth_main; Wait,waitTime=1300; PlayCasterBindEffect,effectID=3409; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
