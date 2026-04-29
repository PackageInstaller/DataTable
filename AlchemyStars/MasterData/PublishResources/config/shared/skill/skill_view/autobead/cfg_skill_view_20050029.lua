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
    {audioID = 9102, audioType = 1}
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayEffectAtCasterPos,effectID=200500108; Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    700,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    700,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10021,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  }
}
return config, "ID", key
