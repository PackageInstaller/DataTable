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
      " PlayAudio,audioID=6136,audioType=1; PlayCasterAnimation,animName=Skill02; Wait,waitTime=500; PlayCasterBindEffect,effectID=3197; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3196,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
