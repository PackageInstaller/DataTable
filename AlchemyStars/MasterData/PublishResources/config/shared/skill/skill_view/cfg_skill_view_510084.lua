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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID =513; Wait,waitTime=363; PlayTargetTurnToCaster; DataSelectDamageInfo,damageInfoIndex = 1; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=509,turnToTarget=1,deathClear=0; Wait,waitTime=333; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=509,turnToTarget=1,deathClear=0; Wait,waitTime=0; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5080, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID =505; "
    }
  }
}
return config, "ID", key
