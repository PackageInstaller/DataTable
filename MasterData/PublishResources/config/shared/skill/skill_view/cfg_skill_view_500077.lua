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
      " ShowHideTrapHead,isShow=0; Wait,waitTime=1000; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=281; PlayCasterBindEffect,effectID=282; Wait,waitTime=2000; ShowHideTrapHead,isShow=1; PlayCasterTrapRound; "
    }
  }
}
return config, "ID", key
