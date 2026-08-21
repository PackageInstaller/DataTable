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
      " PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_01,visible=0; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_03,visible=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    100,
    {
      " Wait,waitTime=500; PlayCasterVisible,visible=1; PlayCasterAnimation,animName=Death; Wait,waitTime=2000; "
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
      " Wait,waitTime=2400; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
