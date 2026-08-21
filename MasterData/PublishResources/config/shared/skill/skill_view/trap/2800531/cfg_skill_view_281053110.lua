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
      " PlayCasterTrapRoundShow,visible=0,text=!; PlayCasterAnimationCleanTrigger,animName=Skill01; PlayCasterAnimationCleanTrigger,animName=Skill01_Exit; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=8003,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayTargetAddBuff,buffID=30181,remove=1,label=RemoveBossBuff; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    200,
    {
      " PlayCasterBindEffect,effectID=3358; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " DataSelectDamage,damageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=dodamage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=dodamage; "
    }
  },
  {
    5,
    5,
    0,
    2,
    3,
    0,
    {
      " PlayTargetAddBuff,buffID=28005313; PlayTargetAddBuff,buffID=28005314; PlayTargetAddBuff,buffID=30181; "
    }
  }
}
return config, "ID", key
