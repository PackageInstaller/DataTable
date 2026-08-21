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
      " AbyssEffectSp,effectMask=1613,effectBottom=3176,effectSide=3177,type=1; Wait,waitTime=200; AbyssEffectSp,effectMask=1613,effectBottom=3176,effectSide=3177,type=2; "
    }
  }
}
return config, "ID", key
