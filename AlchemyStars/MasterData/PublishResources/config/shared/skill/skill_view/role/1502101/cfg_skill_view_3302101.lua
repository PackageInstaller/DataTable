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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; "
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 2689,audioType=1; PlayCasterBindEffect,effectID=150210105; PlayCasterBindEffect,effectID=150210106; PlayCasterBindEffect,effectID=150210108; Wait,waitTime=800; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=250; PlayTeleportAsMoving,speed=25; PlayRoleTeleport,type=9; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; PlayCasterAnimation,animName=AtkUlt3; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    850,
    {
      "PlayCasterBindEffect,effectID=150210109;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1400,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamageIndex,damageIndex=1,damageStageIndex=2; PlayCommonBeHitByDamageIndex,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain1; Wait,waitTime=50; DataSelectNextDamageIndex; Jump,condition=CheckDamageIndex2Valid,goto=doAgain1; Wait,waitTime=500; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    1250,
    {
      " DataSelectDamageIndex,damageIndex=1,damageStageIndex=3; PlayCommonBeHitByDamageIndex,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain2; Wait,waitTime=50; DataSelectNextDamageIndex; Jump,condition=CheckDamageIndex2Valid,goto=doAgain2; Wait,waitTime=500; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamageIndex,damageIndex=1,damageStageIndex=4; PlayCommonBeHitByDamageIndex,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain3; Wait,waitTime=50; DataSelectNextDamageIndex; Jump,condition=CheckDamageIndex2Valid,goto=doAgain3; Wait,waitTime=500; "
    }
  },
  {
    8,
    8,
    0,
    2,
    1,
    1400,
    {
      " Wait,waitTime=200; DataSelectDamage,damageIndex=1,damageStageIndex=5; PlayCasterBindEffect,effectID=150210111; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain4; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain4; Wait,waitTime=500;"
    }
  },
  {
    9,
    9,
    0,
    2,
    1,
    1150,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=3; DataSelectNextDamage,label=doAgain5; Jump,condition=CheckDamageIndexValid,goto=doAgain5; PlayCasterBindEffect,effectID=150210110; Wait,waitTime=500; "
    }
  },
  {
    10,
    10,
    0,
    2,
    1,
    1400,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=40021001,label=doAgain6; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain6; "
    }
  }
}
return config, "ID", key
