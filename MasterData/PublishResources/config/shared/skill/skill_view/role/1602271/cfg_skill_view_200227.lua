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
      " PlayAudio,audioID = 160227102,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|1,goto=phaseEnd; DataSelectDamage,damageIndex=1; PlayCasterAnimation,animName = AtkChain1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID =160227101; Wait,waitTime=800; PlayTargetBindEffect,effectID=160227103; Wait,waitTime=200; PlayTargetBindEffect,effectID=160227104; Wait,waitTime=1000; PlayAudio,audioID = 160227103,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160227105,turnToTarget=0,deathClear=0; Wait,waitTime=500; PlaySelectObjAnimation,objName=eff_1602271_chain_gezi_UAV,animName=effanim_1602271_chain_gezi_UAV_02; Wait,waitTime=1000; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=410227120; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=6|1,goto=phaseEnd; DataSelectDamage,damageIndex=1; PlayCasterAnimation,animName = AtkChain1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID =160227101; PlayCasterBindEffect,effectID =160227102; Wait,waitTime=800; PlayTargetBindEffect,effectID=160227103; Wait,waitTime=200; PlayTargetBindEffect,effectID=160227104; Wait,waitTime=1000; PlayAudio,audioID = 160227103,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160227105,turnToTarget=0,deathClear=0; DataSelectDamage,damageIndex=2; PlayCasterAnimation,animName = AtkChain2; PlayAudio,audioID = 160227102,audioType=1; PlayCasterTurnToTarget; Wait,waitTime=500; PlayTargetBindEffect,effectID=160227103; Wait,waitTime=300; PlaySelectObjMoveToDamagePos,objName=eff_1602271_chain_gezi_UAV,time=66,block=1,form=1,to=2,skillEffectType=1; Wait,waitTime=66; PlaySelectObjAnimation,objName=eff_1602271_chain_gezi_UAV,animName=effanim_1602271_chain_gezi_UAV_02; Wait,waitTime=450; PlayAudio,audioID = 160227103,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160227105,turnToTarget=0,deathClear=0; Wait,waitTime=2000; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=410227120; "
    }
  }
}
return config, "ID", key
