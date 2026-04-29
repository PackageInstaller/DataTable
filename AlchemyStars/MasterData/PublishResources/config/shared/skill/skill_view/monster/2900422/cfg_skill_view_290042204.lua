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
      " PlayCasterEffectHolder,effHolderType=BeforeFly,isShow=0; PlayCasterBindEffect,effectID=275; PlayCasterAnimation,animName=Fly; Wait,waitTime=1899; PlayMoveBoard,sceneRoot1=scxt_stage_01,sceneRoot2=scxt_stage_02,dirX=0,dirY=1,times=4; DataSelectScopeGridRange,effectType=1,damageStageIndex=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1235,step=4,offset=0.5|0.5,label=playRangeEffect; Wait,waitTime=200; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
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
      effectIDList = {339}
    }
  },
  {
    3,
    3,
    51,
    1,
    1,
    0,
    {isPlay = false}
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
