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
      " PlayCasterAnimation,animName = Skill07; PlayCasterBindEffect, effectID=2775; PlayAudio,audioID = 6088,audioType=1; PlayEffectOffsetScopeCenter,effectID=2776,offset=0|0; Wait,waitTime=3600; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=redoDamage; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
