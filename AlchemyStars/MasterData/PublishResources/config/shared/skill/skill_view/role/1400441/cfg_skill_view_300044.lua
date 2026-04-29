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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400441,waitTime = 2000;"
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
      " PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 3034,audioType=1; PlayCasterBindEffect,effectID=1529; PlayCasterBindEffect,effectID=1533; PlayAudio,audioID = 2130,audioType=1; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 1530,flyTime = 200,flyTrace = 1,isBlock = 0,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1532,turnToTarget=1,deathClear=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectScopeGridRange,effectType=62; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=62,isRotate=1,label=playRangeEffect; PlayGridRangeEffect,effectID=1531; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
