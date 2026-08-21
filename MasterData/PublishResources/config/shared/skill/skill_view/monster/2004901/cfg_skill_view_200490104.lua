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
      " PlayCasterBindEffect,effectID=200490102; PlayCasterAnimation,animName=Death; Wait,waitTime=1800; PlayCasterSuicide; PlayDeadEffect,deadType = 1; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; "
    }
  }
}
return config, "ID", key
