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
      " PlayAudio,audioID =3072,audioType=1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=1756; DataSelectDamage,damageIndex = 1; Wait,waitTime=200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1757,turnToTarget=1,deathClear=0; Wait,waitTime=133; "
    }
  }
}
return config, "ID", key
