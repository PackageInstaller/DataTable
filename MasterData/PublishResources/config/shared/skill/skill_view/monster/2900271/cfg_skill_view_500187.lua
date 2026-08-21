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
      " PlayCasterVisible,visible=1; PlayCasterMaterialAnim,animName=eff_2900271_born; Wait,waitTime=4000; StopCasterMaterialAnim,animName=eff_2900271_born; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterAnimation,animName=Born; PlayAudio,audioID = 5013,audioType=1; PlayCasterBindEffect,effectID=609; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
