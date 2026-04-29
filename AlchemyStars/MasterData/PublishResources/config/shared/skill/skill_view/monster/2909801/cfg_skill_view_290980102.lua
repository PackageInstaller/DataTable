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
      " PlayCasterBindEffect,effectID=290980104; PlayCasterMaterialAnim,animName=effanim_2909801_skill2_main; PlayAudio,audioID=29098012; Wait,waitTime=200; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffectScorpion,effectID=290980105,step=2,offset=0.5|0.5,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
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
