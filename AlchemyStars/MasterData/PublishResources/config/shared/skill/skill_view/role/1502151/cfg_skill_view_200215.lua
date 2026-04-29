local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 150215103,audioType=1; PlayCasterBindEffect,effectID=150215111; PlayCasterSubMaterialAnim,nodeName=1502151_weapon,animName=effanim_1502151_chain_weapon_mat; Wait,waitTime=3500; "
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
      " PlaySkillAttackRange,showTime=500,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    520,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=150215112,isRotate=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=50; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1620,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=50; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
