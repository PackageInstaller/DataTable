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
      " PlayMonsterMoveGrid; Wait,waitTime=200; PlayGridDark,darkType=0; PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=3162; PlayCasterBindEffect,effectID=3164; Wait,waitTime=200; PlayAudio,audioID=6129,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1550,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3163,turnToTarget=1,deathClear=0; Wait,waitTime=600; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayGridDark,darkType=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
