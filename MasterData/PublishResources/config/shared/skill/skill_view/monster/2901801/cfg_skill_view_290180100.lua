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
      " PlayCasterBindEffect,effectID=3278; PlayAudio,audioID=6138,audioType=1; PlayCasterAnimation,animName=birth; PlayCasterMaterialAnim,animName=eff_2901801_birth_in; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; "
    }
  }
}
return config, "ID", key
