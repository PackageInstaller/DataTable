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
    37,
    1,
    0,
    0,
    {
      castEffectID = 748,
      castAnimation = "Disappear",
      castDuration = 600,
      stealthDuration = 750,
      appearEffectID = 743,
      appearAnimation = "Appear",
      appearDuration = 1300
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
      " Wait,waitTime=1350; PlayAudio,audioID = 5033,audioType=1; PlayCasterBindEffect,effectID=747; "
    }
  },
  {
    3,
    3,
    45,
    1,
    2,
    0,
    {
      prob = 100,
      tipsList = {290024101}
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    0,
    {
      " PlayCasterBindEffect,effectID=834; "
    }
  },
  {
    5,
    5,
    0,
    1,
    2,
    1000,
    {
      " PlayCasterBindEffect,effectID=833; "
    }
  },
  {
    6,
    6,
    0,
    1,
    0,
    0,
    {
      "PlayCasterRenderState,renderState=1;"
    }
  }
}
return config, "ID", key
