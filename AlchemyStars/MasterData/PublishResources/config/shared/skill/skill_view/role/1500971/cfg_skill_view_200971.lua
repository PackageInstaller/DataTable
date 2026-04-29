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
    2,
    1,
    0,
    0,
    {
      effectparam = "2253",
      castAnimationName = "AtkChain",
      finishDelayTime = 2333,
      buffDelayTime = 2200,
      buffNeedImmediatelyEffect = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 2252,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    150,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=2254,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    300,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetAnimatiorSpeed,speed=0,label=doAgain; PlayTargetBeHitEffect,hitEffectID=2255; PlayTargetMaterialAnim,animName=eff_1500971_atkchain_ice; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    1300,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetAnimatiorSpeed,speed=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
