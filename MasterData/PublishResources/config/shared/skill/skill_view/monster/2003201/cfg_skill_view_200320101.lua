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
      " PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID=200320101; PlayAudio,audioID = 7043,audioType=1; DataSelectDamage,damageIndex = 1; Wait,waitTime=780; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200320103,turnToTarget=1,deathClear=false; Wait,waitTime=1420; "
    }
  }
}
return config, "ID", key
