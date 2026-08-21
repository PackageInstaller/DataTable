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
      " PlayCasterRenderState,renderState=2,caster=Board; PlayEffectAtCasterPos, effectID=1058; Wait,waitTime=800; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
