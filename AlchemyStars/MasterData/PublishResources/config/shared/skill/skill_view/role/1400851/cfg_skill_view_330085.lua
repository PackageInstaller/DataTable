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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1400851,waitTime = 2000; "
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
      "PlayAudio,audioID = 2208,audioType=1;"
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
      " PlayCasterBindEffect,effectID=1731; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=1200; PlayCasterVisible,visible=0; Wait,waitTime=500; PlayCasterVisible,visible=1; PlayCasterAnimation,animName=AtkUlt1; PlayCasterBindEffect,effectID=1733; Wait,waitTime=2000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex = 1; PlayEffectAtTargetPos,effectID=1732; Wait,waitTime=100; DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex=1, label=doAgain1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1734,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  }
}
return config, "ID", key
