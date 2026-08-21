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
      " PlayCasterBindEffect,effectID=3563; PlayAudio,audioID =5026,audioType=1; PlayCasterMaterialAnim,animName=eff_2902601_skill03_skin_out; Wait,waitTime=500; PlayTransformation; PlayCasterMaterialAnim,animName=eff_2902601_skill03_skin_in; PlayCasterAnimation,animName=Trans; Wait,waitTime=600; PlayCasterBindEffect,effectID=3564; PlayRecoverFromGreyHP; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
