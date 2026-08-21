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
      " PlayPlayerRotateToPickup; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2393,audioType=1; PlayCasterBindEffect,effectID = 3212; PlayCameraEffect,effectID = 3215; Wait,waitTime=500; PlayCasterBindEffect,effectID = 3213; Wait,waitTime=1100; PlayCasterBindEffect,effectID = 3214; Wait,waitTime=2000; "
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
  }
}
return config, "ID", key
