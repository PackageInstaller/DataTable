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
      " PlayCasterAnimation,animName = Skill03; PlayAudio,audioID =6063,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID3; Wait,waitTime=2000; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=8; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=PARAM.effectID1,step=4,offset=0.5|0.5,label=playRangeEffect; PlayAudio,audioID =6064,audioType=1; Wait,waitTime=200; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID2,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
