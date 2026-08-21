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
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 5076,audioType=1; PlayCasterBoneSRT, bone=Control, SRT=T, to=0|0|0, duration=100; PlayAudio,audioID=2056; PlayCasterBindEffect,effectID=534; PlayCasterBindEffect,effectID=533; Wait,waitTime=500; "
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
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    0,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    3,
    0,
    {
      " PlayCasterEffectHolder,effHolderType=Idle,isShow=1; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; Wait,waitTime=1000; PlayCasterTrapRound; "
    }
  }
}
return config, "ID", key
