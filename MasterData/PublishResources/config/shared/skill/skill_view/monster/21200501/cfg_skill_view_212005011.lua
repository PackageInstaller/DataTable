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
    2,
    1,
    0,
    0,
    {
      effectparam = "1041",
      castAnimationName = "AtkUlt",
      finishDelayTime = 0,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterBindEffect,effectID=1042; PlayAudio,audioID = 2088,audioType=1; Wait,waitTime=740; PlaySkillAttackRange,showTime=600; "
    }
  },
  {
    3,
    3,
    65,
    1,
    0,
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
