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
      "PlayDeleteWaringArea;"
    }
  },
  {
    2,
    2,
    38,
    1,
    1,
    0,
    {
      effectIDList = {277, 339}
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 6022,audioType=1;"
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterAnimation,animName=Skill01_down; Wait,waitTime=1830; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayEffectAtCasterPos,effectID=PARAM.effectID2; Wait,waitTime=1000; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=Skill01_up; "
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    100,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=0; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    6,
    6,
    27,
    2,
    4,
    100,
    {hitAnim = "Hit"}
  },
  {
    7,
    7,
    0,
    2,
    4,
    1000,
    {
      " PlayCasterBindEffect,effectID=PARAM.effectID3; "
    }
  },
  {
    8,
    8,
    34,
    2,
    4,
    1000,
    {
      gridEffectID = 319,
      gridEffectDelayTime = 0,
      gridIntervalTime = 100,
      showTimeDelay = 1000
    }
  },
  {
    9,
    9,
    0,
    2,
    5,
    0,
    {
      " PlaySummonTrap,trapID=40; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
