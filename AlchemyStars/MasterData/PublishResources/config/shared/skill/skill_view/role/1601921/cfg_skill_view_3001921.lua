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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600141,waitTime = 2000; "
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
      " PlayAudio,audioID = 2637,audioType=1; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=4700; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    300,
    {
      " PlayCasterMaterialAnim,animName=effanim_1601921_atkult_skin01; PlayCasterBindEffect,effectID=160192106; PlayCasterVisible,visible=0; PlayTeamHUDVisible,visible=0; UiBattleVisible,visible=0; "
    }
  },
  {
    4,
    4,
    60,
    1,
    2,
    1200,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160192108
      }
    }
  },
  {
    5,
    5,
    60,
    1,
    4,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160192110
      }
    }
  },
  {
    6,
    6,
    0,
    2,
    5,
    1110,
    {
      "DataSelectPickupGrid,gridIndex=1; PlayMoveSceneEffectToPickPos, sceneEffID=160192111, sceneEffX=-3.072, sceneEffY=0, sceneEffZ=-2.315, moveTime=120;"
    }
  },
  {
    7,
    7,
    0,
    1,
    2,
    2500,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=160192114,pickUpIndex=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    8,
    8,
    0,
    1,
    2,
    2500,
    {
      "PlaySummonTrap,trapID=14;"
    }
  },
  {
    9,
    9,
    0,
    1,
    2,
    3800,
    {
      "PlayEffectAtPickUpIndexGrid,effectID=160192107,pickUpIndex=1;"
    }
  },
  {
    10,
    10,
    0,
    1,
    2,
    4700,
    {
      " PlayCasterBindEffect,effectID=160192109; Wait,waitTime=300; PlayCasterVisible,visible=1; PlayTeamHUDVisible,visible=1; UiBattleVisible,visible=1; PlayCasterAnimation,animName = AtkUlt1a; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
