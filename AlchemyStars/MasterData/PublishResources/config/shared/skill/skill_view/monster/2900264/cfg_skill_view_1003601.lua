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
      " PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=2430; PlayCasterBindEffect,effectID=2429; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=2428; Wait,waitTime=1000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=false; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 2294, audioType = 1}
  }
}
return config, "ID", key
