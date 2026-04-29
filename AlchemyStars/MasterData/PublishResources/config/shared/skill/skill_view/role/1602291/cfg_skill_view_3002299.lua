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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601381,waitTime = 2000; "
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
      " PlayCasterBindEffect,effectID =160229106; PlayEffectAGridPos,effectID=160229107,gridPosX=5,gridPosY=5; PlayCasterAnimation,animName = AtkUlt; PlayDarkScreen,enable=1; PlayAudio,audioID = 160229104,audioType=1; PlayCasterPreviewEffectAnimation,anim=eff_1602291_atkult_gezi01_out; PlayTetrisEffectOnPickUpPos,tetrisEffectList=160229104|160229111|160229112|160229113|160229114|160229115|160229116; Wait,waitTime=3000; DeleteCasterPreviewEffectAnimation; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=2803501,label=playRangeEffect; PlayGridRangeConvert,dataSource=4; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=3000; PlayDarkScreen,enable=0; "
    }
  }
}
return config, "ID", key
