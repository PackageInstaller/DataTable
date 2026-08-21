local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local common = {
  {
    " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
  }
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
      " PlayCasterAnimation,animName=Skill01; PlayAudio,audioID=8007,audioType=1; PlayCasterBindEffect,effectID=3471; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1300,
    common[1]
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayMoveBoard,sceneRoot1=scxt_stage_01,sceneRoot2=scxt_stage_02,dirX=0,dirY=1,times=4; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    1000,
    {
      " PlayCasterAnimation,animName=MoveEnd; Wait,waitTime=500; PlayCasterAnimation,animName=MoveEnd2; "
    }
  },
  {
    5,
    5,
    0,
    1,
    4,
    0,
    common[1]
  }
}
return config, "ID", key
