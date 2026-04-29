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
      " PlayCasterRenderState,renderState=2,caster=Board; "
    }
  },
  {
    2,
    2,
    34,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
