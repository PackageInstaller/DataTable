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
      " PlayAudio,audioID=290560103,audioType=1; PlayDeleteWaringArea; PlayCasterAnimation,animName=PassiveSkill; PlayCasterBindEffect,effectID =290560103; PlayCasterBindEffect,effectID =290560104; PlayCasterMaterialAnim,animName=PARAM.animName; "
    }
  },
  {
    2,
    2,
    34,
    1,
    0,
    0,
    {
      gridEffectDelayTime = 10,
      gridIntervalTime = 0,
      showTimeDelay = 10
    }
  }
}
return config, "ID", key
