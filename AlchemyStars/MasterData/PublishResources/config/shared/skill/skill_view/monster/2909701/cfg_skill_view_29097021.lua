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
    0,
    0,
    0,
    {
      " PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; PlayAudio,audioID = 29097011,audioType=1; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=290970107,step=4,offset=0.5|0.5,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; "
    }
  }
}
return config, "ID", key
