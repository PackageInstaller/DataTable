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
      " PlayDeleteWaringArea; PlayCasterEffectHolder,effHolderType=BeforeFly,isShow=0; PlayAudio,audioID=2049,audioType=1; PlayCasterBindEffect,effectID=275; PlayCasterAnimation,animName=Fly; Wait,waitTime=1899; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=7; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=274,step=4,offset=0.5|0.5,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    2,
    2,
    38,
    1,
    1,
    0,
    {
      effectIDList = {339}
    }
  },
  {
    3,
    3,
    51,
    1,
    1,
    0,
    {isPlay = false}
  },
  {
    4,
    4,
    0,
    1,
    1,
    1899,
    {
      " PlaySummonTrap,trapID=PARAM.trapID1,label=foreach; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
