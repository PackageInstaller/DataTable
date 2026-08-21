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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401371,waitTime = 2000;"
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
      " PlayAudio,audioID = 160230103,audioType=1; PlayCasterAnimation,animName=AtkUlt; PlayCameraEffect,effectID=160230112; PlayCasterBindEffect,effectID=160230105; DataSelectDamage,damageIndex=1; PlayTurnToPickUpDirection; PlayGridDark,darkType=2,duration=0.25,endValue=0.5; Wait,waitTime=700; PlayGridDark,,darkType=2,duration=0.8,endValue=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    3000,
    {
      " DataSelectDamage,damageIndex=1; PlayFlyEffectCasterToTarget,flyEffectID = 160230109,flyTrace = 1,offsetx=0,offsety=0.84,offsetz=0,flyTime=130,targetPos=Hit,isBlock=0,finalWaitTime=1000,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    3130,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160230107,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3280,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4002301,stageIndex=1,label=doAgain; PlayTargetAddBuff,buffID=4002301,stageIndex=2,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
