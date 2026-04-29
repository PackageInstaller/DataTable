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
      " PlayCasterLegacyAnimation,animNames=eff_2800221_huode; PlayAudio,audioID = 8000,audioType=1; Wait,waitTime=100; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1401,turnToTarget=1,deathClear=0; Wait,waitTime=100; "
    }
  }
}
return config, "ID", key
