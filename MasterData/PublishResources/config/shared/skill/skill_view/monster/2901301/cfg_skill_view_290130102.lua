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
      " PlayAudio,audioID=6134,audioType=1; PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID=3204; PlayCasterBindEffect,effectID=3203; Wait,waitTime=550; PlayCasterBindEffect,effectID=3205; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
