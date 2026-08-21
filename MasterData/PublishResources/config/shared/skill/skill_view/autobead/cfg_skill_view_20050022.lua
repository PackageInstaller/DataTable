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
    43,
    1,
    0,
    0,
    {audioID = 9101, audioType = 1}
  },
  {
    2,
    2,
    60,
    1,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 200500101
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCameraEffect,effectID=200500102; Wait,waitTime=3000; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    50,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=80; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    50,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10041,label=buffAgain; Wait,waitTime=80; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; Wait,waitTime=3000; "
    }
  }
}
return config, "ID", key
