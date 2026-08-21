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
      " PlayRoleTeleport,type=9, onlySelf=1,stageIndex=1; PlayCasterVisible,visible=1; PlayAudio,audioID = 6033,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectatk; PlayCasterBindEffect,effectID=PARAM.effectatklight; PlayRoleTeleport,type=5, onlySelf=1,stageIndex=1; PlayRoleTeleport,type=9, onlySelf=1,stageIndex=2; PlayTeleportAsMoving,speed=9,stageIndex=2,notifyBuff=0; "
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
      " Wait,waitTime=1000; PlayRoleTeleport,type=9, onlySelf=1,stageIndex=3; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " Wait,waitTime=0; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " Wait,waitTime=300; PlayRoleTeleport,type=3, onlySelf=1,stageIndex=3; PlayRoleTeleport,type=5, onlySelf=1,stageIndex=3; PlayRoleTeleport,type=6, onlySelf=1,stageIndex=3; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; "
    }
  },
  {
    5,
    5,
    38,
    1,
    1,
    2600,
    {
      effectIDList = {
        1403,
        1404,
        1415,
        1416,
        1427,
        1428,
        1439,
        1440
      }
    }
  }
}
return config, "ID", key
