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
      " PlayCasterAnimation,animName = AtkChain; Wait,waitTime=450; PlayCasterBindEffect,effectID = 3488; Wait,waitTime=3800; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2395, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " DataSelectResult,effectType=5,index=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=41014901,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2456,audioType=1; PlayCasterBindEffect,effectID = 3513; Wait,waitTime = 3300; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    1400,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3514,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
