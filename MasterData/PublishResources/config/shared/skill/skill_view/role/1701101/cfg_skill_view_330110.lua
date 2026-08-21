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
local common = {
  {
    " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=2454,label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
  }
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1701101,waitTime = 2000;"
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
      " PlayCasterAnimation,animName=AtkUlt1; PlayCasterBindEffect,effectID = 2443; PlayCameraEffect,effectID = 2445; PlayCasterBindEffect,effectID = 2446; PlayAudio,audioID = 2282; Wait,waitTime=3333; PlayCasterVisible,visible=0; Wait,waitTime=1666; PlayCasterVisible,visible=1; PlayCasterAnimation,animName=AtkUlt2; PlayCasterBindEffect,effectID = 2447; PlayCasterBindEffect,effectID = 2448; Wait,waitTime=2200; "
    }
  },
  {
    3,
    3,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 2444
      }
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    3500,
    common[1]
  },
  {
    5,
    5,
    0,
    2,
    1,
    3800,
    common[1]
  },
  {
    6,
    6,
    0,
    2,
    1,
    4100,
    common[1]
  },
  {
    7,
    7,
    0,
    2,
    1,
    4400,
    common[1]
  },
  {
    8,
    8,
    0,
    2,
    1,
    4700,
    common[1]
  },
  {
    9,
    9,
    0,
    2,
    1,
    5800,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2453,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
