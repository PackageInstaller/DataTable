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
      " PlayAudio,audioID=6224,audioType=1; PlaySnakeHeadMove; Wait,waitTime=220; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290290101,turnToTarget=1,deathClear=0; PlayAudio,audioID=6225,audioType=1; Wait,waitTime=780; "
    }
  }
}
return config, "ID", key
