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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600271,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID = 3000; PlayCasterBindEffect,effectID = 3001; PlayCasterBindEffect,effectID = 3002; PlayCameraEffect,effectID = 3003; Wait,waitTime=6400; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2334, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    3550,
    {
      " PlayCasterToPickupDirTrajectory,effectID=3005,flySpeed=100, degressiveCount=5, directionType=1, destroyEffectID=3006, effectReduceSize=0.4,hideGO1Name=1/mesh,hideGO2Name=1/par,hideGO2WaitTime=1200,outBoardCount=5,destroyKnifeWaitTime=1200; PlayCasterToPickupDirTrajectory,effectID=3005,flySpeed=100, degressiveCount=5, directionType=4, destroyEffectID=3006, effectReduceSize=0.4,hideGO1Name=1/mesh,hideGO2Name=1/par,hideGO2WaitTime=1200,outBoardCount=5,destroyKnifeWaitTime=1200; PlayCasterToPickupDirTrajectory,effectID=3005,flySpeed=100, degressiveCount=5, directionType=5, destroyEffectID=3006, effectReduceSize=0.4,hideGO1Name=1/mesh,hideGO2Name=1/par,hideGO2WaitTime=1200,outBoardCount=5,destroyKnifeWaitTime=1200; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3550,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3004,turnToTarget=1,deathClear=0,label=playRangeEffect1; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    3550,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=2; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3004,turnToTarget=1,deathClear=0,damageStageIndex=2,label=playRangeEffect1; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    3550,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=3; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3004,turnToTarget=1,deathClear=0,damageStageIndex=3,label=playRangeEffect1; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; "
    }
  }
}
return config, "ID", key
