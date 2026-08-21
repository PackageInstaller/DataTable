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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1300511,waitTime = 2000;"
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
      " PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2103,audioType=1; PlayCasterBindEffect,effectID=575; PlayCasterBindEffect,effectID=577; Wait,waitTime=3800; "
    }
  },
  {
    3,
    3,
    73,
    2,
    1,
    2500,
    {
      bulletEffectId = 0,
      oneGridFlyTime = 0,
      bombEffectId = 576,
      bombDelayTime = 0,
      bombEffectId2 = 0,
      damageDelayTime = 1150,
      hitAnimName = "Hit",
      hitEffectId = 0,
      delayTime = 1850
    }
  }
}
return config, "ID", key
