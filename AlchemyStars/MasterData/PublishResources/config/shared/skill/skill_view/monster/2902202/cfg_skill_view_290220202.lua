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
      " PlayAudio,audioID=6181,audioType=1; PlayCasterTeleportByAnim,leftAnim=Skill02_2,rightAnim=Skill02_1,leftAnimLen=1667,rightAnimLen=1733; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " DataSelectResult,effectType=8,index=1; Wait,waitTime=800; PlayEffectTeleportNewPos,effectID=3528; "
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1000; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1000; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1000; PlayAllHitBack; "
    }
  },
  {
    6,
    6,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=800; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  }
}
return config, "ID", key
