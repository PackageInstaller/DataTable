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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600961,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2586,audioType=1; PlayCasterBindEffect,effectID=160181114; "
    }
  },
  {
    3,
    3,
    96,
    2,
    1,
    0,
    {
      checkTrapIDList = "16018111",
      singleGridMonsterEffectDelay = 1050,
      singleGridMonsterEffectID = 160181118,
      singleGridMonsterEffectLoopAnim = "eff_1601811_uit_small_loop",
      singleGridMonsterEffectLoopAnimDelay = 1333,
      multiGridMonsterEffectDelay = 0,
      multiGridMonsterEffectID = 160181116,
      multiGridMonsterEffectLoopAnim = "eff_1601811_uit_big_ring_loop",
      multiGridMonsterEffectLoopAnimDelay = 5333,
      multiGridMonsterFlagEffectID = 160181117
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2500,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;"
    }
  }
}
return config, "ID", key
