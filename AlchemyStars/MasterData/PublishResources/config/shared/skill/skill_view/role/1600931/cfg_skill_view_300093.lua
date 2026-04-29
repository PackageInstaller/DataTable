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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600111,waitTime = 2000;"
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
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|1,goto=phaseEnd; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterTurnToTarget; PlayAudio,audioID = 2285,audioType=1; PlayCasterAnimation,animName =AtkUlt1; PlayEffectAtCasterPos, effectID=2311; Wait,waitTime=500; PlayRoleTeleport, type=3; Wait,waitTime=66; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterTurnToTarget; PlayCasterAnimation,animName =AtkUltAOE1; PlayCasterBindEffect, effectID=2312; PlayCasterBindEffect, effectID=2315; PlayCasterBindEffect, effectID=2316; Wait,waitTime=600; DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2317,turnToTarget=1,trapNotPlayHitEffect=1,label=damage1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damage1; Wait,waitTime=1200; DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phase2End; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2318,turnToTarget=1,label=damage2; PlayAudio,audioID = 2288,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damage2; Wait,waitTime=33,label=phase2End; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phase3End; PlayTargetBeHitEffect,hitEffectID=2319,label=zhanshatexiao; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=zhanshatexiao; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phase3End; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=demage3; PlayAudio,audioID = 2287,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=demage3; Wait,waitTime=33,label=phase3End; Wait,waitTime=500; Jump,condition=CheckCasterHasBuff,param=4200931|0,goto=phaseEnd; DataSelectDeadTarget,damageIndex = 1; Jump,condition=CheckDeadTarget,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=2322,label=doAgain; PlayFlyEffectCasterToTarget,flyEffectID=2321,flyTime=500,offsetx=0,offsety=0.7,offsetz=0,flyTrace=1,isBlock=0,caster=Target,target=Caster; DataSelectNextDeadTarget; Jump,condition=CheckDeadTarget,goto=doAgain; Wait,waitTime=500; PlayEffectAtCasterPos, effectID=2320; "
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
      " Jump,condition=CheckDamageSkillResultTargetCount,param=6|1,goto=phaseEnd; PlayCasterAnimation,animName =AtkUlt; PlayAudio,audioID = 2286,audioType=1; PlayEffectAtCasterPos, effectID=2311; Wait,waitTime=500; PlayRoleTeleport, type=3; Wait,waitTime=66; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName =AtkUltAOE; PlayEffectAtCasterPos, effectID=2312; PlayEffectAtCasterPos, effectID=2316; PlayEffectAtCasterPos, effectID=2310; DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; Wait,waitTime=1166; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2314,turnToTarget=1,label=damage1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damage1; Wait,waitTime=1200; DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phase2End; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2318,turnToTarget=1,label=damage2; PlayAudio,audioID = 2288,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damage2; Wait,waitTime=33,label=phase2End; Wait,waitTime=500; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phase3End; PlayTargetBeHitEffect,hitEffectID=2319,label=zhanshatexiao; PlayAudio,audioID = 2287,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=zhanshatexiao; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=3; Jump,condition=CheckDamageIndexValid,result=0,goto=phase3End; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=demage3; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=demage3; Wait,waitTime=33,label=phase3End; Wait,waitTime=500; Jump,condition=CheckCasterHasBuff,param=4200931|0,goto=phaseEnd; DataSelectDeadTarget,damageIndex = 1; Jump,condition=CheckDeadTarget,result=0,goto=phaseEnd; PlayTargetBeHitEffect,hitEffectID=2322,label=doAgain; PlayFlyEffectCasterToTarget,flyEffectID=2321,flyTime=500,offsetx=0,offsety=0.7,offsetz=0,flyTrace=1,isBlock=0,caster=Target,target=Caster; DataSelectNextDeadTarget; Jump,condition=CheckDeadTarget,goto=doAgain; Wait,waitTime=500; PlayEffectAtCasterPos, effectID=2320; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|0,goto=phaseEnd; PlayCasterAnimation,animName =AtkUlt; PlayAudio,audioID = 3015,audioType=1; PlayEffectAtCasterPos, effectID=2311; Wait,waitTime=500; PlayRoleTeleport, type=3; Wait,waitTime=66; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName =AtkUltAOE; PlayEffectAtCasterPos, effectID=2312; PlayEffectAtCasterPos, effectID=2316; PlayEffectAtCasterPos, effectID=2310; Wait,waitTime=1166; DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2314,turnToTarget=1,label=damage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=damage; Wait,waitTime=1833; "
    }
  }
}
return config, "ID", key
