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
      effectparam = "573",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 0
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
      " PlayAudio,audioID = 2102,audioType=1; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    65,
    1,
    1,
    2500,
    {
      gridEff = 574,
      hit = {anim = "Hit", eff = 0},
      interval = 50,
      random = true
    }
  }
}
return config, "ID", key
