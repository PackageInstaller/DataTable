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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,petID=1200501,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    2,
    2,
    1,
    0,
    {
      effectparam = "1041",
      castAnimationName = "AtkUlt",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=1042; PlayAudio,audioID = 2088,audioType=1; Wait,waitTime=740; PlaySkillAttackRange,showTime=600; "
    }
  },
  {
    4,
    4,
    65,
    2,
    1,
    650,
    {
      gridEff = 1043,
      hit = {anim = "Hit", eff = 0},
      interval = 100,
      random = true
    }
  }
}
return config, "ID", key
