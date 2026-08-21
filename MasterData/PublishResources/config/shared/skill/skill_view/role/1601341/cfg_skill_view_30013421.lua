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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601341,waitTime = 2000;"
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
      " PlayAudio,audioID = 2393,audioType=1; PlayCameraEffect,effectID = 3215; PlayCasterAnimation,animName = AtkUlt; PlayCasterMaterialAnim,animName=effanim_1601341_atkult_out; PlayCasterBindEffect,effectID = 160134103; Wait,waitTime=350; PlayCasterVisible,visible=0; Wait,waitTime=300; PlayCasterVisible,visible=1; PlayShowCasterOnPickUpGrid,pickUpIndex=1; PlayTurnToPickUpPosDirection,pickUpIndex=2; PlayCasterAnimation,animName = AtkUlt1; PlayCasterMaterialAnim,animName=effanim_1601341_atkult_in; Wait,waitTime=30; PlayCasterBindEffect,effectID = 160134101; Wait,waitTime=170; PlayCasterBindEffect,effectID = 160134105; Wait,waitTime=850; PlayCasterBindEffect,effectID = 160134104; Wait,waitTime=250; PlayCasterVisible,visible=0; Wait,waitTime=50; PlayShowCasterOnPickUpGrid,reset=1; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt2; PlayCasterMaterialAnim,animName=effanim_1601341_atkult_in_1; Wait,waitTime=100; PlayCasterBindEffect,effectID = 160134102; Wait,waitTime=2100; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    900,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
