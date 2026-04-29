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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600231,waitTime = 2000;"
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
      " PlayAudio,audioID = 2178,audioType=1; "
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
      " PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=3000; "
    },
    {"", "1,0"}
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      "PlayCasterBindEffect,effectID=433; PlayCasterBindEffect,effectID=435;"
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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=410137,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    6,
    6,
    78,
    2,
    1,
    1600,
    {
      effectID = 434,
      intervalTime = 100,
      effectScale = 1.3,
      downDisance = -50,
      waitDownTime = 2666,
      downTime = 100,
      waitTime = 933,
      upTime = 100,
      waitDamageTime = 66,
      hitEffectID = 0,
      hitAnimName = "Hit"
    }
  }
}
return config, "ID", key
