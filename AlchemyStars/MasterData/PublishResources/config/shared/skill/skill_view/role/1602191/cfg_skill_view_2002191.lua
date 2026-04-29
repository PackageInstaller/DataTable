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
      " PlayCasterAnimation,animName=AtkChain; PlayCameraEffect,effectID=160219106,bindBoard=1; PlayBoardBindEffectAnim,effectID=160219106,animNames=effanim_1602191_chain_ping_in; PlayAudio,audioID = 160219102,audioType=1; PlayCasterBindEffect,effectID =160219107; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 160219108,flyTime = 300 ,offsetx=0,offsety=0,offsetz=0,flyTrace=2,isBlock=0,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; DataSelectDamage,damageIndex = 2; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160219108,flyTime=300,flyTrace=2,isBlock=0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; DataSelectDamage,damageIndex = 3; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160219108,flyTime=300,flyTrace=2,isBlock=0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; DataSelectDamage,damageIndex = 4; PlayFlyEffectFromLastTargetToTarget,flyEffectID = 160219108,flyTime=300,flyTrace=2,isBlock=0,originalBoneName=Hit,targetPos=Hit,finalWaitTime=500; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=end; PlayFlyEffectCasterToTarget,flyEffectID = 160219108,flyTime = 300 ,offsetx=0,offsety=0,offsetz=0,flyTrace = 2,isBlock = 0,targetPos=Hit,caster=Target,target=Caster,finalWaitTime=500,label=end; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219109,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219110,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219110,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; DataSelectDamage,damageIndex = 4; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160219109,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160219107,audioType=1; Wait,waitTime=500; Jump,condition=CheckIsLastDamage,goto=last; Wait,waitTime=1000,label=last; PlayBoardBindEffectAnim,effectID=160219106,animNames=effanim_1602191_chain_ping_out; Wait,waitTime=500; PlayDeleteBoardBindEffect,effectID=160219106; "
    }
  }
}
return config, "ID", key
