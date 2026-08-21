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
      " PlayCasterAnimation,animName=Transform_a; PlayAudio,audioID=6261,audioType=1; PlayCasterMaterialAnim,animName=eff_2902201_transform_mat; Wait,waitTime=350; PlayCasterBindEffect,effectID=290220113; Wait,waitTime=50; PlayCameraEffect,effectID=290220211; Wait,waitTime=200; PlayTransformation; PlaySwitchBodyAreaResult; PlayCasterAnimation,animName=Transform_b; PlayCasterBindEffect,effectID=290220114; PlayCasterBindEffect,effectID=290220212; PlayCasterMaterialAnim,animName=eff_2902202_transform_mat; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    27,
    1,
    0,
    0,
    {
      hitAnim = "Hit",
      hitEffectID = 0,
      turnToTarget = 1
    }
  }
}
return config, "ID", key
