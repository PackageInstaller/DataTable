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
    52,
    1,
    0,
    0,
    {
      effectID = 524,
      effectType = 2,
      rotation = {
        angle = 0,
        axis = {
          x = 0,
          y = 1,
          z = 0
        }
      },
      translation = {
        angle = 0,
        axis = {
          x = 0,
          y = 0,
          z = 0
        },
        offset = 0
      }
    }
  },
  {
    2,
    2,
    23,
    1,
    1,
    0,
    {showTimeDelay = 0}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      "PlayCasterVisible,visible=0;"
    }
  },
  {
    4,
    4,
    30,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      bestEffectTime = 0,
      finishDelayTime = 1000
    }
  }
}
return config, "ID", key
