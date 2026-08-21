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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; "
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
      " PlayAudio,audioID = 2685,audioType=1; PlayTurnToSpecifiedPos,gridX=5,gridY=5; PlayCasterSubMaterialAnim,nodeName=1602091_weapon,animName=eff_1602091_atkult_weapon; PlayCasterAnimation,animName=AtkUlt1; PlayCasterBindEffect,effectID=160209116; Wait,waitTime=850; PlayCasterBindEffect,effectID=160209115; PlayFlyEffectCasterToTarget,flyEffectID=160209117,flyTime=160,flyTrace=1,offsetx=0.35,offsety=1.2,offsetz=0.4,boardCenterPos=1,targetoffsety=4,isBlock=1; "
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
        gridPos = {x = 5, y = 5},
        effectID = 160209119
      }
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2900,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
