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
      " PlayEntityVisible,visible=1,trapID=390330101; PlayCasterLegacyAnimation,animNames=eff_390330101_idle; "
    }
  }
}
return config, "ID", key
