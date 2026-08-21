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
      " ShowHideTrapHead,isShow=0; PlayCasterAnimation,animName = Birth; Wait,waitTime=1000; PlayCasterAttachEffectHolder,effHolderType=Idle,effId=535; PlayCasterAttachEffectHolder,effHolderType=Charge,effId=536; PlayCasterAttachEffectHolder,effHolderType=Charge,effId=537; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; PlayCasterTrapRound; ShowHideTrapHead,isShow=1; "
    }
  }
}
return config, "ID", key
