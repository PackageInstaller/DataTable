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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600301,waitTime = 2000; "
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
      " Jump,condition=CheckBuffIndexValid,goto=phaseEnd; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimationByBuffLayer,animNameList= AtkUlt1|AtkUlt,layerCountList=0|40; PlayCasterBindEffectByBuffLayer,effectIDList=160189116|160189106|160189107,layerCountList=0|40|80; PlayCasterBindEffectByBuffLayer,effectIDList=160189117|160189111,layerCountList=0|40; PlayCameraEffect,effectID=160189113; PlayAudio,audioID = 2606,audioType=1; PlayCasterBindEffectByBuffLayer,effectIDList=160189115|160189109|160189110,layerCountList=0|40|80; Wait,waitTime=2200; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayChangeBuffLayer; Wait,waitTime=3800; "
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
      " DataSelectBuff,buffIndex = 1; PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID=160189112; PlayCasterBindEffect,effectID=160189114; PlayAudio,audioID = 2607,audioType=1; PlayTargetAddBuff,buffEffectType=40618911,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1800; "
    }
  }
}
return config, "ID", key
