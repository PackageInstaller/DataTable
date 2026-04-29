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
      "PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 3058,audioType=1; PlayCasterBindEffect,effectID=1641; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=1642,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1300; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doagain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doagain2; Wait,waitTime=600; "
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
