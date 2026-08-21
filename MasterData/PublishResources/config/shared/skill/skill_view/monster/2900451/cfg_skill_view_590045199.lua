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
      " PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName=die; PlayCasterMaterialAnim,animName=monster_death_dark; PlayCasterBindEffect,effectID=1059; PlayCasterBindEffect,effectID=PARAM.effectDie; Wait,waitTime=3500; PlayCasterVisible,visible=0; "
    }
  }
}
return config, "ID", key
