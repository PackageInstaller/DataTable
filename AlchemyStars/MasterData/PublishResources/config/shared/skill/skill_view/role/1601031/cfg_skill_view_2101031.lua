local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      "PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2269,audioType=1; PlayCasterBindEffect,effectID=2333; PlayCasterBindEffect,effectID=2334; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=2335,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0,label=doAgain3; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain3; PlayCasterRefreshBuffView,buffID=4101032; Wait,waitTime=600; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1500,
    {
      "PlayAudio,audioID = 3059,audioType=1;"
    }
  }
}
return config, "ID", key
