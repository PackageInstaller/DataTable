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
      " PlayCasterAnimation,animName=Death; PlayVoice,voiceID=6288; PlayCasterBindEffect,effectID =290520101; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=2500; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; "
    }
  }
}
return config, "ID", key
