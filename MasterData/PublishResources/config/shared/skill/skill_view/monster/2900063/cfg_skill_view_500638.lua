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
      " PlayCasterBindEffect, effectID=1457; PlayCasterBindEffect, effectID=1456; PlayCasterAnimation,animName = skill01; PlayAudio,audioID = 6026,audioType=1; PlayEffectOffsetScopeCenter,effectID=1455,offset=0|0; Wait,waitTime=3600; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=redoDamage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=redoDamage; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    2300,
    {
      gridEffectDelayTime = 900,
      gridIntervalTime = 100,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
