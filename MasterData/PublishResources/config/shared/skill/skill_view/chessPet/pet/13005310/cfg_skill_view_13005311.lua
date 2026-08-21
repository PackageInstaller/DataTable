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
      " PlayCasterAnimation,animName=Skill01; PlayAudio,audioID = 2109,audioType=1; PlayCasterBindEffect,effectID=993; Wait,waitTime=600; DataSelectDamage,damageIndex=1; Jump,condition=CheckTargetCountInScope,param=1,goto=criticalDamageFx,label=damageBegin; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=995; Jump,condition=CheckTrue,goto=damageEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=994,label=criticalDamageFx; Wait,waitTime=33,label=damageEnd; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damageBegin; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
