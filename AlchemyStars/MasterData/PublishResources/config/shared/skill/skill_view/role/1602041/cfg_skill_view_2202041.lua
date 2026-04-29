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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160204103; PlayCasterBindEffect,effectID =160204106; PlayCasterMaterialAnim,animName=eff_1602041_atkchain_rongjie_in; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|1,goto=phaseEnd; PlayAudio,audioID = 2658,audioType=1; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=160204110; Wait,waitTime=930; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,finalWaitTime=2000; Wait,waitTime=1100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=303; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,caster=Target,target=Caster,finalWaitTime=2000; Wait,waitTime=67; PlayCasterMaterialAnim,animName=eff_1602041_atkchain_rongjie_out; PlayCasterBindEffect,effectID =160204109; "
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
      " Jump,condition=CheckDamageSkillResultTargetCount,param=5|2,goto=phaseEnd; PlayAudio,audioID = 2657,audioType=1; Wait,waitTime=930; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,finalWaitTime=2000; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160204105,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 2; Wait,waitTime=320,label=fly; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160204104,flyTime = 60,flyTrace = 1,isBlock = 0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=2000; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160204105,turnToTarget=1; Wait,waitTime=250; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=fly; DataSelectLastDamage; PlayFlyEffectCasterToTarget,flyEffectID = 160204104,flyTime = 60 ,offsetx=0,offsety=0.5,offsetz=0,flyTrace = 1,isBlock = 0,targetPos=Hit,caster=Target,target=Caster,finalWaitTime=2000; PlayCasterMaterialAnim,animName=eff_1602041_atkchain_rongjie_out; PlayCasterBindEffect,effectID =160204109; "
    }
  }
}
return config, "ID", key
