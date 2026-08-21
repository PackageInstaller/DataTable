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
      " PlayAudio,audioID = 6248,audioType=1; Wait,waitTime=1000; PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=PARAM.Disappear; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=400; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    800,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=15; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290410113,delayTime=70,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1000,
    {
      " ShowSummonThingBySortPos, sortType=15, eachDelayTime=80; Wait,waitTime=1000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayCasterSuicide; "
    }
  }
}
return config, "ID", key
