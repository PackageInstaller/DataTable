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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1501351,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID = 3221; Wait,waitTime=1600; PlayCasterBoneRotationByPickSector,bone=Root,absAngle=90,duration=2000; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2383, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    1600,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=14,sortParam=9|90; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3222,turnToTarget=1,deathClear=0,label=playRangeEffect1; Wait,waitTime=160; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; "
    }
  }
}
return config, "ID", key
