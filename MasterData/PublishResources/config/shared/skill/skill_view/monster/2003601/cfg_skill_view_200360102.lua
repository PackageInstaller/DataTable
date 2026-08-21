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
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=200360101; Wait,waitTime=20; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,hitBackSpeed=80; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    33,
    {audioID = 2043, audioType = 1}
  }
}
return config, "ID", key
