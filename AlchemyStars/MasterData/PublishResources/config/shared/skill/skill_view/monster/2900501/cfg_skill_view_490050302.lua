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
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6031,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill02EffectId; PlayCasterBindEffect,effectID=PARAM.Skill02BoneEffectId; Wait,waitTime=1900; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.Skill02GridEffectId,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; DataSelectScopeGridRange,effectType=82; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=2; PlayIslandConvert,patternEffectID=PARAM.IslandEffectId; Wait,waitTime=300; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2000,
    {
      "PlayMultiTraction;"
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlaySummonTrap,trapID=61; "
    }
  }
}
return config, "ID", key
