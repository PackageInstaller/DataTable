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
      " PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2172,audioType=1; PlayCasterBindEffect,effectID =1755; Wait,waitTime=500; PlayCasterBindEffect,effectID =452; PlayCasterVisible,visible=0; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    500,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterEffectAtTargetPos,effectID=453,randomDir=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    1100,
    {
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt02; PlayCasterBindEffect,effectID =454; Wait,waitTime=3500; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    3600,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
