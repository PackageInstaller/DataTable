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
      " PlayCasterBindEffect,effectID=2440; PlayCasterBindEffect,effectID=2442; PlayCasterAnimation,animName=Skill02; PlayAudio,audioID =2281,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1850,
    {
      "DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=2441,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=250; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayAddComboNum; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1401,turnToTarget=1,deathClear=0,label=doAgain; PlayAudio,audioID = 8000,audioType=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
