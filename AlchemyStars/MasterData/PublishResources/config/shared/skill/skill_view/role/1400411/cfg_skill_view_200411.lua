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
      " PlayCasterAnimation,animName=AtkChain; Wait,waitTime=200; PlayCasterBindEffect,effectID=593; PlayAudio,audioID = 2126,audioType=1; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    65,
    1,
    1,
    500,
    {
      gridEff = 594,
      hit = {anim = "Hit", eff = 0},
      interval = 100,
      random = true
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
