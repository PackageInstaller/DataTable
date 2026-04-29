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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =19600; PlayAudio,audioID = 2150,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1500,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=19700,label=doAgain; Wait,waitTime=100; PlayAudio,audioID = 2193,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    300,
    {
      " Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
