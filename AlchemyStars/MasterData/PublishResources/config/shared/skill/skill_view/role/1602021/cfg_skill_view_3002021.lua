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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1601161,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 2652,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=160202109; PlayCasterBindEffect,effectID=160202112; Wait,waitTime=4500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1900,
    {
      " PlayEffectAtPickUpIndexGrid,effectID=160202110,pickUpIndex=1; Wait,waitTime=3000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2000,
    {
      "PlaySummonTrap,trapID=160202100;"
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
