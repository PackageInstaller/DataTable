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
      " PlayCasterAnimation,animName=Atk; Wait,waitTime=500; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; PlayGridRangeEffect,effectID=290290102,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,damageStageIndex=1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayAudio,audioID=6226,audioType=1; Wait,waitTime=1700; "
    }
  }
}
return config, "ID", key
