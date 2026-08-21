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
      " PlayCasterBindEffect,effectID=3117; PlayAudio,audioID = 6122,audioType=1; Wait,waitTime=760; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName=birth; PlayCasterMaterialAnim,animName=eff_2900681_birth_main; PlayCasterBindEffect,effectID=3129; Wait,waitTime=400; "
    }
  }
}
return config, "ID", key
