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
    38,
    1,
    0,
    0,
    {
      effectIDList = "PARAM.RemoveEffect"
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
      " PlayCasterAnimation,animName = Skill03; PlayAudio,audioID = 6018,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill03EffectId; Wait,waitTime=6400; PlayTransformation; PlayCasterBindEffect,effectID=PARAM.Skill03CrazyEffectId; PlayCasterRefreshBuffView,buffID=50099; "
    }
  }
}
return config, "ID", key
