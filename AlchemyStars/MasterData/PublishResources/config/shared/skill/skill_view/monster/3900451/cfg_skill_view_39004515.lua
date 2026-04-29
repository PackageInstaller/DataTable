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
      " PlayCasterRenderState,renderState=2,caster=Board; PlayCasterBindEffect,effectID=PARAM.effectghost; Wait,waitTime=1200; PlayCasterTurnToPlayer; PlayCasterVisible,visible=1; PlayCasterBindEffect,effectID=PARAM.effecteye; PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
