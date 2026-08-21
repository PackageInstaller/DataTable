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
      " PlayAudio,audioID = 5002,audioType=1; Wait,waitTime=210; PlayEffectAtCasterPos,effectID=837; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=redoDamage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=redoDamage; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10051,label=redoBuff; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=redoBuff; "
    }
  }
}
return config, "ID", key
