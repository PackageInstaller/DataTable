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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=824; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=825,turnToTarget=1,deathClear=false; Wait,waitTime=1420; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    200,
    {audioID = 5091, audioType = 1}
  }
}
return config, "ID", key
