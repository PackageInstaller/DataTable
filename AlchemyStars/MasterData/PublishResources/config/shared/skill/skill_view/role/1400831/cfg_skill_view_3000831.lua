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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400831,waitTime = 2000; "
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
      "PlayAudio,audioID = 2205,audioType=1;"
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
      " PlayCasterBindEffect,effectID=1674; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=100; PlayCasterVisible,visible=0; PlayTeamHUDVisible,visible=0; DataSelectPickupGrid,gridIndex=1; Wait,waitTime=500; PlaySelectCenterGridEffect,effectID=140083301,intervalTime=0; Wait,waitTime=1500; DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1695,turnToTarget=2,deathClear=0, label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      "Wait,waitTime=1800; PlayCasterVisible,visible=1; PlayTeamHUDVisible,visible=1; PlayCasterAnimation,animName=AtkUlt1; PlayCasterBindEffect,effectID=1676; Wait,waitTime=2000;"
    }
  }
}
return config, "ID", key
