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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600381,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCameraEffect,effectID=3880; PlayEffectAtCasterPos,effectID =3879,useRenderDir=1; PlayAquaGronruEffect,effectID =3895; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayAudio,audioID =2509,audioType=1;"
    }
  },
  {
    4,
    4,
    60,
    1,
    2,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 3894
      }
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    0,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=3878; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    0,
    {
      " Wait,waitTime=7000;"
    }
  }
}
return config, "ID", key
