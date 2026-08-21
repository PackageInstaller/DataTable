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
    1070,
    {
      " PlayCasterBindEffect,effectID=200500107; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1070,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=21050274,remove=1,label=doAgain; PlayTargetAddBuff,buffID=21050275,remove=1; PlayTargetAddBuff,buffID=21050276,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    43,
    1,
    1,
    1070,
    {audioID = 2441, audioType = 1}
  }
}
return config, "ID", key
