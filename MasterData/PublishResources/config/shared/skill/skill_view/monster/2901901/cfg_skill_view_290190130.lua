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
      " DataSelectDamage,damageIndex=1; PlayCasterTurnToTarget; PlayCasterAnimation,animName=Skill03; PlayAudio,audioID=6167,audioType=1; PlayCasterBindEffect,effectID=3389; Wait,waitTime=700; PlayCasterBindEffect,effectID=3392; Wait,waitTime=200; PlayFlyEffectCasterToTarget,flyEffectID=3390,flyTime=100,flyTrace=1,flyEaseType=InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3391,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
