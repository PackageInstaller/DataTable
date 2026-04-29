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
      " PlayCasterAnimation,animName=Atk; PlayTeleportAsMoving,time=300,dontSetGridDown=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    500,
    {
      " Jump,condition=CheckCasterHasBuff,param=40021916|0,goto=phaseEnd; Wait,waitTime=300; PlayEffectAtCasterPos,effectID=160219117; Wait,waitTime=200; PlayReplaceTrapModel,trapID=16021913|16021914|16021917|16021918|160219111|160219112|160219115|160219116|160219117|160219118,replacePrefab=1602191.prefab,isPetModel=1,needMaterial=1; PlayAudio,audioID = 160219103,audioType=1; PlayCasterBindEffect,effectID =160219112; PlayCasterBindEffect,effectID =160219113; PlayCasterMaterialAnim,animName=common_shadoweff; Wait,waitTime=900; PlayCasterAnimation,animName=AtkChain; PlayCameraEffect,effectID=160219106,bindBoard=1; PlayBoardBindEffectAnim,effectID=160219106,animNames=effanim_1602191_chain_ping_in; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    500,
    {
      " Jump,condition=CheckCasterHasBuff,param=40021916|1,goto=phaseEnd; Wait,waitTime=300; PlayEffectAtCasterPos,effectID=160219116; Wait,waitTime=200; PlayReplaceTrapModel,trapID=16021911|16021912|16021913|16021914|16021915|16021916|16021917|16021918|16021919|160219110|160219111|160219112|160219113|160219114|160219115|160219116|160219117|160219118,replacePrefab=1602191.prefab,isPetModel=1,needMaterial=1; PlayAudio,audioID = 160219103,audioType=1; PlayCasterBindEffect,effectID =160219111; PlayCasterMaterialAnim,animName=common_shadoweff; Wait,waitTime=900; PlayCasterAnimation,animName=AtkChain; PlayCameraEffect,effectID=160219106,bindBoard=1; PlayBoardBindEffectAnim,effectID=160219106,animNames=effanim_1602191_chain_ping_in; "
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    1900,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 160219108,flyTime = 300 ,offsetx=0,offsety=0,offsetz=0,flyTrace=2,isBlock=0,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; DataSelectDamage,damageIndex = 2; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160219108,flyTime=300,flyTrace=2,isBlock=0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; DataSelectDamage,damageIndex = 3; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160219108,flyTime=300,flyTrace=2,isBlock=0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; DataSelectDamage,damageIndex = 4; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160219108,flyTime=300,flyTrace=2,isBlock=0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; PlayFlyEffectCasterToTarget,flyEffectID = 160219108,flyTime = 300 ,offsetx=0,offsety=0,offsetz=0,flyTrace = 2,isBlock = 0,targetPos=Hit,caster=Target,target=Caster,finalWaitTime=500,label=end; Wait,waitTime=500; "
    }
  },
  {
    5,
    5,
    0,
    1,
    2,
    2400,
    {
      " Jump,condition=CheckCasterHasBuff,param=40021916|0,goto=phaseEnd; DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=last; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219109,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219110,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219110,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219109,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; Wait,waitTime=1000,label=last; PlayBoardBindEffectAnim,effectID=160219106,animNames=effanim_1602191_chain_ping_out; PlayDeleteBoardBindEffect,effectID=160219106; PlayEffectAtCasterPos,effectID=160219117; Wait,waitTime=200; PlayReplaceTrapModel,trapID=16021913|16021914|16021917|16021918|160219111|160219112|160219115|160219116|160219117|160219118,replacePrefab=16021912.prefab; PlayAudio,audioID = 160219103,audioType=1; Wait,waitTime=300; PlayDeleteBoardBindEffect,effectID=160219106; "
    }
  },
  {
    6,
    6,
    0,
    1,
    3,
    2400,
    {
      " Jump,condition=CheckCasterHasBuff,param=40021916|1,goto=phaseEnd; DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=last; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219109,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219110,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219110,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219109,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; Wait,waitTime=1000,label=last; PlayBoardBindEffectAnim,effectID=160219106,animNames=effanim_1602191_chain_ping_out; PlayDeleteBoardBindEffect,effectID=160219106; PlayEffectAtCasterPos,effectID=160219116; Wait,waitTime=200; PlayReplaceTrapModel,trapID=16021911|16021912|16021913|16021914|16021915|16021916|16021917|16021918|16021919|160219110|160219111|160219112|160219113|160219114|160219115|160219116|160219117|160219118,replacePrefab=16021911.prefab; PlayAudio,audioID = 160219103,audioType=1; Wait,waitTime=300; PlayDeleteBoardBindEffect,effectID=160219106; "
    }
  }
}
return config, "ID", key
