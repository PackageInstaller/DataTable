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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID =481; PlayAudio,audioID = 5081,audioType=1; Wait,waitTime=233; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=482,turnToTarget=1,deathClear=0; Wait,waitTime=200; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=482,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
