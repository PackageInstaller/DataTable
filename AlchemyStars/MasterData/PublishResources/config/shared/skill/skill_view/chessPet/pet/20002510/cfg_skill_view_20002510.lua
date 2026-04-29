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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=619; Wait,waitTime=800; PlayFlyEffectCasterToTarget,flyEffectID = 617,flySpeed = 200,flyTrace = 1,isBlock=0; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=618,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextDamage; Wait,waitTime=150; Jump,condition=CheckDamageIndexValid,goto=playRangeEffect; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5086, audioType = 1}
  }
}
return config, "ID", key
