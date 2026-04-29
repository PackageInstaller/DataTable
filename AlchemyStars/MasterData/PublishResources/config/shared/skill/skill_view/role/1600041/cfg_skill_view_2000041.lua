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
    66,
    1,
    0,
    0,
    {
      atkAnim = "AtkChain",
      atkGridCenterEffectID = 81,
      atkGridEffectID = 82,
      centerDelay = 1300,
      centerHitDelay = 1100,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 1500
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      "PlayAudio,audioID = 2162,audioType=1;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    350,
    {
      "PlaySkillAttackRange,showTime=600,isEffectRange=0;"
    }
  }
}
return config, "ID", key
