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
      " PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName=Death; PlayCasterBindEffect,effectID= 290990105; PlayCasterMaterialAnim,animName=effanim_2909901_death_mat; PlayAudio,audioID=29099012,audioType=1; Wait,waitTime=2000; PlayCasterVisible,visible=0; "
    }
  }
}
return config, "ID", key
