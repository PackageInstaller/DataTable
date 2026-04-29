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
      " PlayCasterAnimation,animName = atk02; PlayCasterBindEffect,effectID=200250104; Wait,waitTime=400; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200250105,turnToTarget=1,deathClear=0; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    33,
    {audioID = 6260, audioType = 1}
  }
}
return config, "ID", key
