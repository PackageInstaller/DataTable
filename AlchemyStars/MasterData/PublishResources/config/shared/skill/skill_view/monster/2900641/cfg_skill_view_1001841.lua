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
      " PlayCasterAnimation,animName=skill01; PlayAudio,audioID =6099,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=800; PlayCasterBindEffect,effectID=PARAM.effectID1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1300,
    {
      " Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=3,gridPosY=3,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=4,gridPosY=4,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=6,gridPosY=6,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=7,gridPosY=7,gridDirX=0,gridDirY=-1; Wait,waitTime=100; Wait,waitTime=100; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1300,
    {
      " DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=100; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    100,
    {
      " PlaySummonTrap,trapID=61; "
    }
  }
}
return config, "ID", key
