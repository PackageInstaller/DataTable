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
      " PlayAudio,audioID=6135,audioType=1; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=3200; PlayCasterBindEffect,effectID=3201; Wait,waitTime=1450; PlayCasterBindEffect,effectID=3202; Wait,waitTime=200; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
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
      " DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlaySummonTrap,trapID=61; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
