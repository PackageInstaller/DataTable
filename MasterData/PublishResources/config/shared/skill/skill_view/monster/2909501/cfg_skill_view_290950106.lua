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
      " PlayAudio,audioID = 29095014,audioType=1; PlayCasterMaterialAnim,animName=eff_2909501_01_skill01; PlayCasterAnimation,animName=Skill2; PlayCasterBindEffect,effectID=290950103; Wait,waitTime=2800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    760,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=1; Wait,waitTime=150; DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=2; Wait,waitTime=150; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayAudio,audioID = 3045,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=3; Wait,waitTime=150; DataSelectDamage,damageIndex = 1,damageStageIndex=4; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=4; Wait,waitTime=150; DataSelectDamage,damageIndex = 1,damageStageIndex=5; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,hitBackUseDamagePos=1,damageStageIndex=5; Wait,waitTime=100; "
    }
  }
}
return config, "ID", key
