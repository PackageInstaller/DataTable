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
      " PlayEffectAtCasterPos, effectID=3902; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
