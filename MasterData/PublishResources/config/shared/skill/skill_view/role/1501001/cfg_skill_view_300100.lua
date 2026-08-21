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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1501001,waitTime = 2000;"
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
      "PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2290; PlayCasterBindEffect,effectID=2291; Wait,waitTime=2000; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=2292,label=playRangeEffect; DataSelectDamage,damageIndex = 1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; PlayGridRangeConvert,dataSource=4; Wait,waitTime=50; DataSelectNextDamage; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2500; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2263, audioType = 1}
  }
}
return config, "ID", key
