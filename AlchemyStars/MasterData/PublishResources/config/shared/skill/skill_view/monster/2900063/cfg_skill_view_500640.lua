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
      " PlayCasterBindEffect, effectID=1460; PlayCasterAnimation,animName = skill03; PlayAudio,audioID = 6028,audioType=1; Wait,waitTime=1600; Wait,waitTime=100; DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2300; "
    }
  }
}
return config, "ID", key
