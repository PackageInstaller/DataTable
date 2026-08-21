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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=290980101; PlayCasterMaterialAnim,animName=effanim_2909801_skill1_main; PlayAudio,audioID=29098011; Wait,waitTime=1030; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=290980102,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    100,
    {
      "PlayScorpionSummonMonster,index=1; Wait,waitTime=1500;"
    }
  }
}
return config, "ID", key
