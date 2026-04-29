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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=284; Wait,waitTime=100; PlayFlyEffectCasterToTarget,flyEffectID = 285,flySpeed = 150,flyTrace = 1,isBlock=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=286,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
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
      " PlayCasterRenderState,renderState=2,caster=Board; Wait,waitTime=2500; PlayCasterTrapRound; PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
