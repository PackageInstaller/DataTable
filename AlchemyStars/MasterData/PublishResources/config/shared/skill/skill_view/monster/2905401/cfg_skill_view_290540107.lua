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
      " PlayCasterAnimation,animName=Death; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1000; PlayShowLineRenderer,show=0,selfAll=1,isTrap=1; Wait,waitTime=1000; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; "
    }
  }
}
return config, "ID", key
