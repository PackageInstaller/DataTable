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
    38,
    2,
    0,
    0,
    {
      effectIDList = {833}
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterAnimation,animName = DashSuccess; PlayAudio,audioID = 6044,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=750,turnToTarget=1,deathClear=0; PlayCasterBindEffect,effectID=751; Wait,waitTime=1900; "
    }
  }
}
return config, "ID", key
