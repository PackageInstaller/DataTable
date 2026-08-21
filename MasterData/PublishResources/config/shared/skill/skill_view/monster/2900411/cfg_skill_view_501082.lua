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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6015,audioType=1; PlayCasterBindEffect,effectID=PARAM.SummonEffectId; PlayCasterBindEffect,effectID=PARAM.HandEffectId; DataSelectSummonThing,index=1; PlaySelectGridEffect,effectID=PARAM.SummonGridEffectId; PlayCasterBindEffect,effectID=PARAM.Idle1EffectId; PlayCasterBindEffect,effectID=PARAM.Idle2EffectId; Wait,waitTime=2800; ShowSummonThing; "
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " DataSelectSummonThing,index=2; PlaySelectGridEffect,effectID=PARAM.SummonGridEffectId; Wait,waitTime=2800; ShowSummonThing; "
    }
  }
}
return config, "ID", key
