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
      " PlayCasterBindEffect,effectID=290500112; PlayCasterVisible,visible=0; PlayCasterMaterialAnim,animName=effanim_29050012_skill03_birth; Wait,waitTime=1000; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; StopCasterMaterialAnim,animName=effanim_29050012_skill03_birth; PlayCasterMaterialAnim,animName=effanim_29050012_skill03; "
    }
  }
}
return config, "ID", key
