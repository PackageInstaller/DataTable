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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; PlayDarkScreen,enable=0; "
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=150187107; PlayCasterMaterialAnim,animName=eff_1501871_atkult_xiaoshi; Wait,waitTime=1000; PlayCasterVisible,visible=0; PlayTeamHUDVisible,visible=0; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    200,
    {
      "PlayAudio,audioID = 150187103,audioType=1;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      "PlayCameraEffect,effectID=150187111;"
    }
  },
  {
    5,
    5,
    60,
    2,
    1,
    500,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 150187106
      }
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    500,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=150187105,pickUpIndex=1; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    2500,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=120; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    8,
    8,
    0,
    2,
    1,
    6000,
    {
      " PlayCasterBindEffect,effectID=150187108; PlayCasterMaterialAnim,animName=eff_1501871_atkult_chuxian; Wait,waitTime=500; PlayCasterVisible,visible=1; PlayTeamHUDVisible,visible=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
