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
      " PlayCasterBindEffect,effectID=383; PlayCasterBindEffect,effectID=384; PlayCasterBindEffect,effectID=385; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2123,audioType=1; Wait,waitTime=1000; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime=1000; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckContainCurrentScopeGrid,param=-1_0|1_0|0_-1|0_1|-1_-1|1_1|-1_1|1_-1,result=1,goto=redoHit,label=redo; Wait,waitTime=50; PlayGridRangeEffect,effectID=386; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=redoHit; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=redo; "
    }
  }
}
return config, "ID", key
