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
      " PlayEffectAtCasterPos, effectID=58; Wait,waitTime=500; PlayUIEffect,effectName = UIArriveExit,duaration = 1200; Wait,waitTime=0; PlayEffectAtCasterPos, effectID=58; Wait,waitTime=500; PlayFadeInOutEntity, fadeIn=false, target=player, duration=500; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
