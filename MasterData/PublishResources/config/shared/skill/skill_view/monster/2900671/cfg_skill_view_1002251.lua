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
      " PlayCasterAnimation,animName = Skill05; PlayCasterBindEffect,effectID=2769; PlayAudio,audioID = 6086,audioType=1; PlaySchummerHitbackShowHide,mode=1; Wait,waitTime=500; PlaySchummerHitbackShowHide,mode=2; PlayCasterAnimation,animName = Skill05_2; PlayCasterBindEffect,effectID=2770; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    800,
    {
      " PlaySchummerTowerRealmEffect; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2772,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    500,
    {
      " PlayCasterBindEffect,effectID=2769; PlaySchummerHitbackShowHide,mode=1; Wait,waitTime=500; PlayCasterBindEffect,effectID=2769; PlaySchummerHitbackShowHide,mode=3; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
