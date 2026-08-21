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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160204103; PlayCasterBindEffect,effectID =160204106; PlayCasterMaterialAnim,animName=eff_1602041_atkchain_rongjie_in; PlayAudio,audioID = 2657,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    930,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|1,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,finalWaitTime=2000; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160204105,turnToTarget=1,deathClear=0; Wait,waitTime=320; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,caster=Target,target=Caster,finalWaitTime=2000; Wait,waitTime=60; PlayCasterMaterialAnim,animName=eff_1602041_atkchain_rongjie_out; PlayCasterBindEffect,effectID =160204109; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    930,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=5|2,goto=phaseEnd; PlayAudio,audioID = 2657,audioType=1; Wait,waitTime=930; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,finalWaitTime=2000; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160204105,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 2; Wait,waitTime=320,label=fly; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160204104,flyTime = 60,flyTrace = 1,isBlock = 0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=2000; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160204105,turnToTarget=1; Wait,waitTime=250; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=fly; DataSelectLastDamage; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,caster=Target,target=Caster,finalWaitTime=2000; PlayCasterMaterialAnim,animName=eff_1602041_atkchain_rongjie_out; PlayCasterBindEffect,effectID =160204109; "
    }
  }
}
return config, "ID", key
