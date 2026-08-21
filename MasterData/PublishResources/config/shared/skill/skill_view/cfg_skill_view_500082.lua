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
      " PlayGridDark,darkType=0; PlayEffectAtCasterPos, effectID=58; Wait,waitTime=1200; PlayUIEffect,effectName = UIGoToExit,duaration = 1200; PlayGridDark,darkType=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
