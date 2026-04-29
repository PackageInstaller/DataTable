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
    0,
    2,
    1,
    0,
    {
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2445,audioType=1; PlayCasterBindEffect,effectID=3491; Wait,waitTime=4500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    700,
    {
      " DataSelectResult,effectType=5,index=1; Jump,condition=CheckEffectResultIndex,param=5,goto=phaseEnd; DataSelectResult,effectType=117,index=1; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=3492; PlayGridRangeConvert,dataSource=4; PlaySummonMeantimeLimit,trapDieSkillID=150149112; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    700,
    {
      " DataSelectResult,effectType=117,index=1; Jump,condition=CheckEffectResultIndex,param=117,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=45014903,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
