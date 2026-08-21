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
      " PlayCasterRenderState,renderState=0; PlayDeleteWaringArea; PlayCasterRefreshBuffView,buffID=30072; "
    }
  },
  {
    2,
    2,
    38,
    1,
    1,
    0,
    {
      effectIDList = {
        936,
        937,
        975
      }
    }
  },
  {
    3,
    3,
    1,
    1,
    1,
    0,
    {
      castEffectID = 984,
      castAnimation = "Skill03_c",
      hitPointDelay = 350,
      onHitAnimation = "Hit",
      hitEffectID = 887,
      castTotalTime = 1833,
      hpDelayTime = 0
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 5002,audioType=1;"
    }
  }
}
return config, "ID", key
