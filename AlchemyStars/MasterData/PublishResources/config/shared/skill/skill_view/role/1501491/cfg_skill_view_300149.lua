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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; "
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2445,audioType=1; PlayCasterBindEffect,effectID=3491; Wait,waitTime=4500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    700,
    {
      " DataSelectResult,effectType=117,index=1; PlaySummonMeantimeLimit,trapDieSkillID=150149112; "
    }
  },
  {
    4,
    4,
    30,
    2,
    1,
    700,
    {
      gridEffectID = 3492,
      bestEffectTime = 500,
      finishDelayTime = 1500
    }
  }
}
return config, "ID", key
