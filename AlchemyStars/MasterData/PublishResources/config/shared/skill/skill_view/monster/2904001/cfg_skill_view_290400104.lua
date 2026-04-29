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
      " PlayAudio,audioID = 6242,audioType=1; PlayCasterBindEffect,effectID=290400109; PlayCasterMaterialAnim,animName=eff_2904001_skin_@crazy; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
