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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; "
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
      " PlayColorPaletteClear; PlayTurnToPickUpDirection; PlayCasterBindEffect,effectID =150228106; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 150228102,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    800,
    {
      " DataSelectResult,effectType=117,index=1; PlayRobotSummonMeantimeLimit,trapDieSkillID=150228102; "
    }
  }
}
return config, "ID", key
