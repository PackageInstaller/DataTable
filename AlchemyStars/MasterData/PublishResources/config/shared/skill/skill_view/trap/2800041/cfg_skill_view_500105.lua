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
      " PlayCasterBoneSRT,bone=Control,SRT=T,delta=0|0|0.1,duration=400; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
