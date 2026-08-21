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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6015,audioType=1; PlayCasterBindEffect,effectID=PARAM.SummonEffectId; PlayCasterBindEffect,effectID=PARAM.HandEffectId; DataSelectSummonThing,index=1; PlaySelectGridEffect,effectID=PARAM.SummonGridEffectId; Wait,waitTime=2800; ShowSummonThing; "
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
      " DataSelectSummonThing,index=2; PlaySelectGridEffect,effectID=PARAM.SummonGridEffectId; Wait,waitTime=2800; ShowSummonThing; "
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
      " DataSelectSummonThing,index=3; PlaySelectGridEffect,effectID=PARAM.SummonGridEffectId; Wait,waitTime=2800; ShowSummonThing; "
    }
  },
  {
    4,
    4,
    0,
    1,
    0,
    0,
    {
      " DataSelectSummonThing,index=4; PlaySelectGridEffect,effectID=PARAM.SummonGridEffectId; Wait,waitTime=2800; ShowSummonThing; "
    }
  }
}
return config, "ID", key
