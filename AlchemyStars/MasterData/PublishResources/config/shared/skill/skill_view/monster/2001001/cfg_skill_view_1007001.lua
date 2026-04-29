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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 7006,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=500; PlayCasterHUDVisible,visible=0; Wait,waitTime=700; PlayRoleTeleport,type=5,onlySelf=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2000,
    {
      " PlayRoleTeleport, type=6; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Skill012; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=550; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.effectID3,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID4,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    200,
    {
      " PlaySummonTrap,trapID=60; "
    }
  }
}
return config, "ID", key
