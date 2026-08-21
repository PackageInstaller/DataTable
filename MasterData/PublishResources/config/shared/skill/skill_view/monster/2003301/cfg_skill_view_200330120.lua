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
      " PlayCasterBindEffect,effectID=200330110; PlayCasterMaterialAnim,animName=eff_2904001_skin_@crazy; PlayAudio,audioID = 7063,audioType=1; Wait,waitTime=3600; "
    }
  }
}
return config, "ID", key
