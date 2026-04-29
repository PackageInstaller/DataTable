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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500761,waitTime = 2000;"
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      "PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1659; PlayAudio,audioID = 3102,audioType=1; Wait,waitTime=1250; DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayConvertFlyEffect,dataSource=4,flyEffectID = 1660,flyTime = 200,flyTrace = 2,isBlock = 0,convertEffectID=1661,label=playRangeEffect; DataSelectDamage,damageIndex = 1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; PlayGridRangeConvert,dataSource=4; Wait,waitTime=150; DataSelectNextDamage; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
