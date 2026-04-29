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
      " PlayTrapGroupEffect, effId=561, rotate=1; PlayCasterAttachEffectHolder,effHolderType=Idle,effId=567; "
    }
  }
}
return config, "ID", key
