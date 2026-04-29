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
      " PlayCasterAnimation,animName = skill02; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID =6100,audioType=1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1700,
    {
      " PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=7,gridPosY=6,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=6,gridPosY=7,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=8,gridPosY=6,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=6,gridPosY=8,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=7,gridPosY=4,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=4,gridPosY=7,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=8,gridPosY=4,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=4,gridPosY=8,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=7,gridPosY=2,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=2,gridPosY=7,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=8,gridPosY=2,gridDirX=0,gridDirY=-1; PlayEffectAGridPos,effectID=PARAM.effectID2,gridPosX=2,gridPosY=8,gridDirX=0,gridDirY=-1; Wait,waitTime=100; "
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
      "DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
