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
      " PlayCasterRenderState,renderState=2,caster=Board; PlayCasterBindEffect,effectID=2157; PlayCasterVisible,visible=1; Wait,waitTime=2000; PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
