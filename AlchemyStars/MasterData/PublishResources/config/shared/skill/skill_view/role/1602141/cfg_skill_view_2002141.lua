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
      " PlayAudio,audioID = 160214102,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160214103; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2800,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160214104,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=80; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2200,
    {
      " PlayFlyEffectCrossToGridEdges,flyEffectID=160214105,flySpeed=200,flyTrace=1,offsetx=0,offsety=0.5,offsetz=0; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2800,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=200221,label=buffAgain; PlayTargetAddBuff,buffID=4302141; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  }
}
return config, "ID", key
