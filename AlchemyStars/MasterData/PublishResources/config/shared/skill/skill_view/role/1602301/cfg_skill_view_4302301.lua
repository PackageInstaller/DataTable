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
      " Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160230106,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 160230104,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
