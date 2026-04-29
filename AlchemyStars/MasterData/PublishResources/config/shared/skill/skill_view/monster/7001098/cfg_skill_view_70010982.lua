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
      " PlayCasterAnimation,animName = Skill03; PlayAudio,audioID = 6006,audioType=1; PlayCasterBindEffect,effectID=1256; PlayCasterBindEffect,effectID=1258; Wait,waitTime=1500; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=1257,step=5,offset=0|0,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
