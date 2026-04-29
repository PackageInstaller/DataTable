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
      " PlayAudio,audioID=6133,audioType=1; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=3198; Wait,waitTime=200; PlayCasterBindEffect,effectID=3199; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    200,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
