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
      " PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 160216102,audioType=1; PlayCasterBindEffect,effectID =160216101; PlayCasterBindEffect,effectID =160216102; PlayCasterBindEffect,effectID =160216103; PlayCasterBindEffect,effectID =160216104; PlaySelectObjAnimation,objName=eff_1602161_atkchain_came,animName=eff_1602161_atkchain_main; PlaySelectObjAnimation,objName=eff_1602161_atkchain_came,animName=eff_1602161_atkchain02_came; PlayCasterBindEffect,effectID=160216101; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    850,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayTargetBeHitEffect,hitEffectID=160216105,label=doAgain; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2700; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    850,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1850,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCasterAnimation,animName=AtkChain02; PlayCasterBindEffect,effectID=160216107; PlayAudio,audioID = 160216103,audioType=1; Wait,waitTime=700; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160216108,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
