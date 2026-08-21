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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName = Skill1; PlayCasterBindEffect,effectID =290940101; PlayAudio,audioID = 290940103; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    700,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 290940102,flyTime = 132,flyTrace = 1,offsety = 0.84,isBlock = 0,finalWaitTime=500,targetPos=Hit,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=20; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290940103,turnToTarget=1,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    720,
    {
      " PlayFlyEffectTeamToSummonPos,flyEffectID = 290940104,flyTime = 330,flyTrace = 1,isBlock = 0,finalWaitTime=500; "
    }
  },
  {
    4,
    4,
    34,
    1,
    1,
    800,
    {
      gridEffectID = 0,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
