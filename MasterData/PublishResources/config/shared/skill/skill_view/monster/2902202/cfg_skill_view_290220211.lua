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
      " PlayCasterAnimation,animName=Transform_a; PlayCasterMaterialAnim,animName=eff_2902201_transform_mat; PlayAudio,audioID=6262,audioType=1; Wait,waitTime=350; PlayCasterBindEffect,effectID=290220113; Wait,waitTime=50; PlayCameraEffect,effectID=290220115; Wait,waitTime=200; PlayTransformation; PlaySwitchBodyAreaResult; PlayCasterAnimation,animName=Transform_b; PlayCasterBindEffect,effectID=290220112; PlayCasterBindEffect,effectID=290220114; PlayCasterMaterialAnim,animName=eff_2902202_transform_mat; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
