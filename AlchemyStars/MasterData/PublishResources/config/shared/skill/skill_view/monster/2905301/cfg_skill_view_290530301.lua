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
      " PlayAudio,audioID=6291,audioType=1; PlayDeleteWaringArea; DataSelectDamage,damageIndex=1; PlayEffectOffsetScopeCenter,effectID=290530105,offset=0|0 PlayEffectOffsetScopeCenter,effectID=290530106,offset=0|0 Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlaySummonMeantimeLimit,forceMeanTime=1; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
