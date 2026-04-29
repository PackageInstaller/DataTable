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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401371,waitTime = 2000;"
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
      " PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2379,audioType=1; PlayCasterBindEffect,effectID=3228; Wait,waitTime=4500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1000,
    {
      " PlayBeHitEffectAtPickUpMonster,hitEffectID=3229; "
    }
  },
  {
    4,
    4,
    30,
    2,
    1,
    2500,
    {
      gridEffectID = 0,
      besteffectTime = 1000,
      finishDelayTime = 1000
    }
  }
}
return config, "ID", key
