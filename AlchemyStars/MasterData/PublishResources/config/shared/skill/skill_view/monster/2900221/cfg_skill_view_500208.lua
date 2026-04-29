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
    1000,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=2; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=967,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,bodyArea=4; PlayTargetAddBuff,buffID=20011; Wait,waitTime=200; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    2,
    2,
    38,
    1,
    1,
    1000,
    {
      effectIDList = {
        956,
        957,
        958,
        817,
        821,
        952
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    3233,
    {
      " PlayTransformation; PlayCasterAddBuff,buffID=30241,remove=1; PlayCasterAddBuff,buffID=30243; PlayCasterRenderState,renderState=0; "
    }
  }
}
return config, "ID", key
