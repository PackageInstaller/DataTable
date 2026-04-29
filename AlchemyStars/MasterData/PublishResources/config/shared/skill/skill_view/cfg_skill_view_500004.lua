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
      " PlayCasterEffectHolder,effHolderType=Idle,isShow=0; PlayCasterAnimation,animName = turnright; Wait,waitTime=500; PlayRotateResult; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; "
    }
  }
}
return config, "ID", key
