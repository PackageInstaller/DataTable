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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1501421,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2390,audioType=1; PlayCasterBindEffect,effectID = 3330; PlayCasterLineToPickGridEff,lineOnCaster=Bip001 R Hand,lineOnEffect=lineb,lineEffectID=3332,lineEffectDelay=800,lineEffectDuration=866,gridEffectID=3333,pickUpIndex=1,dirOnPickup=1; Wait,waitTime=2200; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1850,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    800,
    {
      " PlayCasterLineRenderer,lineEffectID=3332,lineTarget=lineb,lineCurrent=Bip001 R Hand; DataSelectScopeGridRange,effectType=1; PlayShowLineRenderer,show=1; Wait,waitTime=866; PlayShowLineRenderer,show=0; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1800,
    {
      " PlayMultiTraction,moveSpeed=6; "
    }
  }
}
return config, "ID", key
