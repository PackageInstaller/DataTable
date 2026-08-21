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
    0,
    0,
    0,
    {
      " PlayCasterRenderState,renderState=1; PlayCasterBindEffect,effectID =952; PlayCasterBindEffect,effectID =954; PlayAudio,audioID = 6050,audioType=1; PlayCasterAnimation,animName = Skill01L; "
    }
  },
  {
    2,
    3,
    30,
    1,
    1,
    1000,
    {
      gridEffectID = 0,
      bestEffectTime = 500,
      finishDelayTime = 1000
    }
  },
  {
    3,
    4,
    23,
    1,
    1,
    1500,
    {showtime = 100}
  },
  {
    4,
    5,
    33,
    1,
    1,
    2566,
    {
      anim = "Skill02L",
      delay = 0,
      effIds = {953}
    }
  }
}
return config, "ID", key
