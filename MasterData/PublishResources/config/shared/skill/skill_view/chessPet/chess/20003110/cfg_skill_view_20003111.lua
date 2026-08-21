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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=250; PlayCasterBindEffect,effectID =3835; PlayAudio,audioID=6209,audioType=1; Wait,waitTime=233; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3836,turnToTarget=1,deathClear=0; Wait,waitTime=277; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
