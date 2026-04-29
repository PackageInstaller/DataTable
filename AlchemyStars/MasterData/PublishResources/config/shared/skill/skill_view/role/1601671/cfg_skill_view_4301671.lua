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
      " PlayAudio,audioID = 2495,audioType=1; PlayFeatureDrawCard; PlayCasterBindEffect,effectID = 3745; Wait,waitTime = 100; "
    }
  }
}
return config, "ID", key
