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
      " PlayCameraEffect,effectID=290530102; PlayAudio,audioID=6295,audioType=1; Wait,waitTime=1750; PlayCasterAnimation,animName=Transform_b; PlayCasterBindEffect,effectID=290530101; PlayCasterMaterialAnim,animName=eff_2902202_transform_out; Wait,waitTime=550; PlayCameraEffect,effectID=290530104; Wait,waitTime=100; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=290530103; PlayCasterMaterialAnim,animName=eff_2905301_transform_mat; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
