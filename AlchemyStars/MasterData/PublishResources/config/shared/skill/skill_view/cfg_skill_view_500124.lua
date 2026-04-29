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
      " PlayCasterBindEffect,effectID=645; PlayCasterAnimation,animName = Skill04; Wait,waitTime=4800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6077, audioType = 1}
  }
}
return config, "ID", key
