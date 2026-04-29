local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterBindEffect,effectID=1701; PlayCasterAnimation,animName = Skill01; Wait,waitTime=500; PlayAudio,audioID = 3105,audioType=1; Wait,waitTime=5300; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2800,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2800,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    2800,
    {
      " DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=60; "
    }
  }
}
return config, "ID", key
