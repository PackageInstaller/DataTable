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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290940103,turnToTarget=1,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    720,
    {
      " PlayFlyEffectTeamToSummonPos,flyEffectID = 290940104,flyTime = 330,flyTrace = 1,isBlock = 0,finalWaitTime=500; "
    }
  },
  {
    3,
    3,
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
