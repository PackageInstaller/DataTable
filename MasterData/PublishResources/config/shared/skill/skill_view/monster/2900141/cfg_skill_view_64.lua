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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=845; PlayCasterTurnToTarget; PlayAudio,audioID=5056; Wait,waitTime=333; DataSelectDamageInfo,damageInfoIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=846,turnToTarget=1,deathClear=0; Wait,waitTime=433; DataSelectDamageInfo,damageInfoIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=847,turnToTarget=1,deathClear=0; Wait,waitTime=1600; "
    }
  }
}
return config, "ID", key
