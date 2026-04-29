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
      " PlayTeamTurnToDirByCenterPosArray; PlayTeamBindEffect,effectID=3082, mode=1; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=30; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;Wait,waitTime=400; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20031,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  }
}
return config, "ID", key
