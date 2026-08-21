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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600041,waitTime = 2000; "
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
      " PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=1800; PlaySelectCenterGridEffect,effectID=89,intervalTime=0; Wait,waitTime=1900; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1200,
    {
      "PlaySkillAttackRange,showTime=600;"
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
      "PlayAudio,audioID = 2160,audioType=1;"
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
