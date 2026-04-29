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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1401021,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=2342; PlayAudio,audioID = 2237,audioType=1; "
    }
  },
  {
    3,
    3,
    38,
    2,
    1,
    2200,
    {
      effectIDList = {2342}
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2200,
    {
      " PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=2343; PlayCasterBindEffect,effectID=2344; Wait,waitTime=300; PlayCasterBindEffect,effectID=2345; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2500,
    {
      " PlayMultiTraction; Wait,waitTime=500; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
