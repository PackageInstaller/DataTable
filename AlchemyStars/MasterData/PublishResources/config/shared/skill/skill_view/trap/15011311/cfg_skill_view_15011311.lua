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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1501131,waitTime = 2000; "
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
      " PlayGridDark,darkType=0; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2313,audioType=1; PlayCameraEffect,effectID=2629; Wait,waitTime=300; PlayCasterBindEffect,effectID=2627; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    3000,
    {
      " PlayEffectAGridPos,effectID=2628,gridPosX=5,gridPosY=5,dirOnPickup=1; "
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    3250,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    27,
    1,
    2,
    3250,
    {
      hitAnim = "Hit",
      hitEffectID = 2631,
      turnToTarget = 1
    }
  }
}
return config, "ID", key
