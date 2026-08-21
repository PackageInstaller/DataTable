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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    200,
    {
      " PlayCasterAnimation,animName =Skill_02; PlayAudio,audioID = 6228,audioType=1; Wait,waitTime=50; PlayTeleportAsMoving,time=500; PlayRoleTeleport,type=9; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    1130,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; PlayGridRangeEffect,effectID=29093012; "
    }
  },
  {
    5,
    5,
    0,
    2,
    3,
    300,
    {
      " PlaySummonTrap,trapID=2909301; "
    }
  }
}
return config, "ID", key
