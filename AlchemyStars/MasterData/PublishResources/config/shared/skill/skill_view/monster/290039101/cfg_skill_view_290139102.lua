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
      " PlayDeleteWaringArea; PlayCasterAnimation,animName=Rain; PlayAudio,audioID = 5064,audioType=1; PlayCasterBindEffect,effectID=777; PlayCasterBindEffect,effectID=778; Wait,waitTime=3400; DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=8; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=776,step=9,offset=1|1,label=playRangeEffect; PlayGridRangeConvert,dataSource=58,isRotate=1; Wait,waitTime=300; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; EffectHolderLegacyAnimation,effHolderType=Permanent,animNames=eff_2900391_red03|eff_2900391_green; "
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
  }
}
return config, "ID", key
