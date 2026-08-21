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
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID=7037,audioType=1; PlayCasterBindEffect,effectID=3383; Wait,waitTime=600; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3384,turnToTarget=1,deathClear=0; Wait,waitTime=600; "
    }
  }
}
return config, "ID", key
