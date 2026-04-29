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
    34,
    0,
    0,
    0,
    {
      gridEffectID = 891,
      gridEffectDelayTime = 0,
      gridIntervalTime = 300,
      showTimeDelay = 0
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    200,
    {
      " PlayCasterLineRenderer,group=Monster|Trap,targerEffectType=3026,lineEffectID=906,lineTarget=Hit,lineCurrent=Hit; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
