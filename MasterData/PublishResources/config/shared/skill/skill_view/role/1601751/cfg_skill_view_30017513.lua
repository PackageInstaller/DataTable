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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160175107
      }
    }
  },
  {
    3,
    3,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160175114
      }
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2555,audioType=1; PlayCasterBindEffect,effectID=160175106; PlayEffectAtPickUpIndexGrid,effectID=160175110,pickUpIndex=1; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2200,
    {
      " DataSelectResult,effectType=184,index=1; PlaySummonScanTrap,label=play; Wait,waitTime=100; PlaySetSummonTrapEffectLayerOrder,targetLayerName=Default,wait=4000; DataSelectNextResult,effectType=184; Jump,condition=CheckEffectResultIndex,param=184,goto=play; Wait,waitTime=4100; "
    }
  }
}
return config, "ID", key
