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
      " PlayAudio,audioID=20035013,audioType=1; PlayCasterTurnToTargetNormal; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=200350101; PlayCasterBindEffect,effectID=200350102; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    600,
    {
      " PlayTeleportAsMoving,time=500,notifyBuff=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    950,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200350106,turnToTarget=1,deathClear=false,damageStageIndex=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    3,
    0,
    1,
    1,
    950,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200350106,turnToTarget=1,deathClear=false,damageStageIndex = 2,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    4,
    0,
    1,
    1,
    950,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
