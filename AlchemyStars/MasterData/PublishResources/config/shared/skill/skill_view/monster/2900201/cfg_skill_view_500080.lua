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
      "PlayAudio,audioID = 5096,audioType=1;"
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
      " PlayCasterBindEffect,effectID=582; PlayCasterAnimation,animName=Skill02_down; Wait,waitTime=1830; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayEffectAtCasterPos,effectID=583; Wait,waitTime=1000; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=Skill02_up; PlayCasterBindEffect,effectID=578; "
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
    0,
    2,
    4,
    1000,
    {
      "PlaySummonTrap,trapID=40; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
