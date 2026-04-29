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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=1649; Wait,waitTime=1500; PlayCasterBindEffect,effectID=1647; Wait,waitTime=1800; "
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
      "PlayAudio,audioID = 3066,audioType=1;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1600,
    {
      " PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    4,
    4,
    65,
    1,
    1,
    2000,
    {
      gridEff = 1648,
      hit = {anim = "Hit", eff = 0},
      interval = 33,
      random = true
    }
  }
}
return config, "ID", key
