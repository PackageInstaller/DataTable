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
      " PlayAudio,audioID = 2660,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=150205112; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1100,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1100,
    {
      " PlayPet1502051ChainTrajectory,trajectoryEffectID=150205113,hitEffectID=0,hitAnimName=Hit,turnToTarget=1,deathClear=0,flyLength=1,singleGridTime=500; "
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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =4202052; PlayTargetAddBuff,buffEffectType =4262052; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;"
    }
  }
}
return config, "ID", key
