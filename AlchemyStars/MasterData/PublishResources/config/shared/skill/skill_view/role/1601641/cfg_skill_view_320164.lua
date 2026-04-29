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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1601641,waitTime = 2000;"
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
      " PlayAudio,audioID = 2501; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayTeleportAsMoving,time=233; PlayCasterAnimation,animName = AtkUlt2; Wait,waitTime=3000; "
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
      " Wait,waitTime = 100; PlayCasterBindEffect,effectID = 3791; Wait,waitTime = 580; PlayCasterBindEffect,effectID = 3792; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    100,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3793,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    30,
    2,
    1,
    933,
    {
      gridEffectID = 3794,
      bestEffectTime = 600,
      finishDelayTime = 1000
    }
  }
}
return config, "ID", key
