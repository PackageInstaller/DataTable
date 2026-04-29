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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=838; PlayCasterTurnToTarget; PlayAudio,audioID=5058; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=839,turnToTarget=1,deathClear=0; Wait,waitTime=1540; "
    }
  }
}
return config, "ID", key
