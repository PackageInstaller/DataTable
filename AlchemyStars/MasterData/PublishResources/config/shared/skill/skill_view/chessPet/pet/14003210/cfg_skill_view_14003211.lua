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
      " PlayCasterAnimation,animName=Atk; PlayAudio,audioID=2116,audioType=1; PlayCasterBindEffect,effectID=456; Wait,waitTime=300; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=457,turnToTarget=1,deathClear=0; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
