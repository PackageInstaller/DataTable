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
    38,
    1,
    0,
    0,
    {
      effectIDList = {834}
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterRefreshBuffView,buffID=30072; PlayCasterRefreshBuffView, buffEffectType =0; PlayCasterBindEffect,effectID=835; PlayCasterAnimation,animName = Charge; Wait,waitTime=900; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayTeleportAsMoving,speed=12; PlayAudio,audioID = 5033,audioType=1; "
    }
  },
  {
    4,
    4,
    0,
    1,
    0,
    0,
    {
      "PlayCasterRenderState,renderState=0;"
    }
  }
}
return config, "ID", key
