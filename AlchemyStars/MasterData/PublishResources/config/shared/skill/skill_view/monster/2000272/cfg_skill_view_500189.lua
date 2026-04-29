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
      " PlayCasterAnimation,animName = Atk; Wait,waitTime=0; PlayCasterBindEffect,effectID=629; Wait,waitTime=800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=630,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5084, audioType = 1}
  }
}
return config, "ID", key
