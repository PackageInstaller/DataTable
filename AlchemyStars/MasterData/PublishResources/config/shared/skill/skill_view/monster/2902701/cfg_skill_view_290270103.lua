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
      " PlayDeleteWaringArea; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=3598; PlayAudio,audioID=6196,audioType=1; PlayCasterBindEffect,effectID=3600; Wait,waitTime=1350; PlayEffectOffsetScopeCenter,effectID=3599,offset=0|0; Wait,waitTime=500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
