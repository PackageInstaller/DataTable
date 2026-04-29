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
      " PlayDeleteWaringArea; Wait,waitTime=400; "
    }
  },
  {
    2,
    2,
    29,
    1,
    1,
    1500,
    {
      warningCenterPosType = 3,
      warningCenterPosParam = 5,
      warningTextEffectID = 339,
      areaRes = ""
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " DataSelectDamage,damageIndex=1; PlayAudio,audioID = 5076,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=Again; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=Again; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=30061,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
