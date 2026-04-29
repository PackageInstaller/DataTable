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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill02; PlayAudio,audioID=29101012,audioType=1; Wait,waitTime=600; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291010104,turnToTarget=1,deathClear=0; PlayAddHpText; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
