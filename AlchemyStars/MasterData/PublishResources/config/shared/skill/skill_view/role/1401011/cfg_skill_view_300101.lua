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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401011,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2283; PlayAudio,audioID = 2234; "
    },
    {"", "1,0"}
  },
  {
    3,
    3,
    0,
    1,
    2,
    700,
    {
      " PlaySkillAttackRange,showTime=200; DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; DataSelectDamage,damageIndex = 1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; PlayGridRangeEffect,effectID=2284; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
