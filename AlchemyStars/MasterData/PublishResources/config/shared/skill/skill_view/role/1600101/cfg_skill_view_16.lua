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
    2,
    1,
    0,
    0,
    {
      effectparam = "380",
      castAnimationName = "AtkChain",
      finishDelayTime = 2767,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    700,
    {
      " PlayAudio,audioID = 2168,audioType=1; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    65,
    1,
    1,
    1400,
    {
      gridEff = 379,
      hit = {anim = "Hit", eff = 0},
      interval = 50,
      random = true
    }
  }
}
return config, "ID", key
