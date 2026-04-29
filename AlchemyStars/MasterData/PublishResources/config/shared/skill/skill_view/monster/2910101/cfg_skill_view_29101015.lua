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
      " PlayCasterBindEffect,effectID= 291010101; PlayCasterMaterialAnim,animName=effanim_2910101_idle_mat; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
