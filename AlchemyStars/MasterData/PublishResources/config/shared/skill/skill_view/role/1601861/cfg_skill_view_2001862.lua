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
      " PlayTurnToSpecifiedDir,dirX=0,dirY=1; PlayCasterAnimation,animName = AtkChain; PlayCasterSubMaterialAnim,nodeName=1601861_weapon,animName=eff_1601861_atkchain_main_weapon; PlayAudio,audioID = 2609,audioType=1; PlayCasterBindEffect,effectID=160186103; PlayCasterBindEffect,effectID=160186107; Wait,waitTime=1500; PlayEffectAtCasterPos,effectID=160186105,useRenderDir=1; Wait,waitTime=2800; "
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
    1780,
    {
      "DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=160186106,turnToTarget=1,deathClear=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
