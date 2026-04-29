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
    38,
    1,
    0,
    0,
    {
      effectIDList = {1836}
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterRenderState,renderState=2,caster=Board; Wait,waitTime=200; PlayCasterAnimation,animName = Death; PlayAudio,audioID = 6056,audioType=1; PlayCasterBindEffect,effectID=1822; PlayCasterBindEffect,effectID=1823; PlayCasterBindEffect,effectID=1824; Wait,waitTime=3000; PlayCasterVisible,visible = 0; PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
