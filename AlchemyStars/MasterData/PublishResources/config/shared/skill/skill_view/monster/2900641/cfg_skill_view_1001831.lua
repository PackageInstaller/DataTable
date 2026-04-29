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
      " PlayCasterAnimation,animName = skill03; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID2; PlayAudio,audioID =6101,audioType=1; Wait,waitTime=1000; PlayCasterHUDVisible,visible=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1800,
    {
      " PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID4,gridPosX=7,gridPosY=7,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID4,gridPosX=6,gridPosY=6,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID4,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID4,gridPosX=4,gridPosY=4,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID4,gridPosX=3,gridPosY=3,gridDirX=0,gridDirY=-1; Wait,waitTime=100; Wait,waitTime=100; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1800,
    {
      " Wait,waitTime=200; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=100; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    0,
    {
      " PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=400; PlayCasterAnimation,animName = skill031; Wait,waitTime=1000; PlayRoleTeleport, type=6; PlayCasterHUDVisible,visible=1; PlayCasterBindEffect,effectID=PARAM.effectID3; "
    }
  },
  {
    5,
    5,
    0,
    2,
    3,
    0,
    {
      " Wait,waitTime=1400; PlaySummonTrap,trapID=61; PlayCasterControlGridDown,enable=1; PlayCasterControlOutLine,enable=1; "
    }
  }
}
return config, "ID", key
