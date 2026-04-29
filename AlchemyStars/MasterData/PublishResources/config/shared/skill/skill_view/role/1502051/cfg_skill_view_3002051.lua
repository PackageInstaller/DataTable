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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600891,waitTime = 2000; "
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
      " PlayTurnToSpecifiedDir,dirX=1,dirY=0; PlayCasterBindEffect,effectID =150205103; PlayCasterBindEffect,effectID =150205107; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2661,audioType=1; PlayCasterSubMaterialAnim,nodeName=1502051_weapon,animName=eff_1502051_atkult_weapon; Wait,waitTime=1200; PlayCasterBindEffect,effectID =150205104; Wait,waitTime=5000; "
    }
  },
  {
    3,
    3,
    60,
    2,
    1,
    1600,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 150205105
      }
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2600,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=150205106,pickUpIndex=1; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3000,
    {
      " DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=150205108,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    4000,
    {
      " PlaySummonTrap,trapID=532400209; "
    }
  }
}
return config, "ID", key
