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
      " PlayCasterAnimation,animName=Skill02; Wait,waitTime=100; PlayCasterEffectHolder,effHolderType=BeforeFly,isShow=1; PlayAudio,audioID=2073,audioType=3; "
    }
  },
  {
    2,
    2,
    29,
    1,
    1,
    500,
    {
      warningCenterPosType = 2,
      warningCenterPosParam = {
        [1] = {x = 3.5, y = 6.5},
        [2] = {x = 7.5, y = 6.5},
        [3] = {x = 1.5, y = 4.5},
        [4] = {x = 3.5, y = 2.5},
        [5] = {x = 8.5, y = 3.5},
        [6] = {x = 6.5, y = 1.5}
      },
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
