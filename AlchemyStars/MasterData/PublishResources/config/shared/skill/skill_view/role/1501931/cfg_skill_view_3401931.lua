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
      " PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID =2621,audioType=1; PlayCasterBindEffect,effectID=150193103; PlayCasterBindEffect,effectID=150193104; Wait,waitTime=2500; PlaySwapPetTeamOrder; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType=4401931,remove=1; PlayTargetAddBuff,buffEffectType=4101470; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    924,
    {
      " PlayTeleportAsMoving,time=99; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; "
    }
  }
}
return config, "ID", key
