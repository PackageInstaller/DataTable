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
      " DataSelectDamage,damageIndex=1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=3632; Wait,waitTime=700; PlayAudio,audioID = 6194,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
