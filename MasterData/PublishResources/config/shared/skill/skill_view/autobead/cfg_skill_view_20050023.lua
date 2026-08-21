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
    1000,
    {audioID = 2330, audioType = 1}
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayEffectAtCasterPos,effectID=394; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    3933,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=31081,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; Wait,waitTime=400; "
    }
  }
}
return config, "ID", key
