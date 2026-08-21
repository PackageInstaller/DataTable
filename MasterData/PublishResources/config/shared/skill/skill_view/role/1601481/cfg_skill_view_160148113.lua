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
      " PlayEntityVisible,visible=1,trapID=16014811; PlayEntityVisible,visible=1,trapID=16014812; PlayEntityVisible,visible=1,trapID=16014813; PlayCasterLegacyAnimation,animNames=eff_1601481_atkult_gezi01_loop; "
    }
  }
}
return config, "ID", key
