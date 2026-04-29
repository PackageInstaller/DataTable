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
      " PlayCasterAnimation,animName=Skill; PlayAudio,audioID = 5012,audioType=1; PlayCasterBindEffect,effectID=612; Wait,waitTime=2800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1600,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit, hitAnimName=Hit, hitEffectID=0, turnToTarget=1, deathClear=0, waitBeHitFinish=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
