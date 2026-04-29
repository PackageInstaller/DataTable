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
      " PlayAudio,audioID = 29095013,audioType=1; PlayCasterAnimation,animName=Skill1_2; PlayCasterBindEffect,effectID=290950111; Wait,waitTime=5000; "
    }
  },
  {
    2,
    2,
    110,
    1,
    1,
    1400,
    {
      startPosEffectID = 290950108,
      bulletEffectID = 290950109,
      spawnIntervalTime = 100,
      flyDelayTime = 960,
      flyTime = 200,
      hitAnimName = "Hit",
      hitEffectID = 290950110,
      bulletOffSet = {
        -0.167,
        0.309,
        1.048
      },
      startPosList = {
        {2, 2},
        {1, 6},
        {5, 9},
        {9, 4},
        {8, 8}
      }
    }
  }
}
return config, "ID", key
