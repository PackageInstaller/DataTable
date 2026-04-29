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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500131,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=1000; PlayCasterBindEffect,effectID=111; PlayAudio,audioID = 3036,audioType=1; "
    }
  },
  {
    3,
    3,
    56,
    2,
    1,
    0,
    {
      targetElements = {1},
      effectID = {113}
    }
  },
  {
    4,
    4,
    24,
    2,
    1,
    2400,
    {
      targetType = 2,
      trajectoryType = 1,
      gridEffectID = 112,
      startHigh = 0.53,
      endHigh = 0,
      flyTotalTime = 600,
      flySpeed = 100,
      finishDelayTime = 2000,
      deltaAngle = 30
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3400,
    {
      "DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4010; PlayTargetAddBuff,buffEffectType=3002; PlayCasterMaterialAnim,animName=common_shield; "
    }
  }
}
return config, "ID", key
