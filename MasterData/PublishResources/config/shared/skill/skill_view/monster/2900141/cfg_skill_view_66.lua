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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=848; PlayCasterTurnToTarget; PlayAudio,audioID=5055; Wait,waitTime=1600; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=849,turnToTarget=1,deathClear=0; PlayTargetAddBuff,buffID=10011; PlayTargetAddBuff, buffEffectType =0; Wait,waitTime=1900; "
    }
  }
}
return config, "ID", key
