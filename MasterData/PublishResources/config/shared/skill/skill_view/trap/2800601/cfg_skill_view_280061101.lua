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
      " PlayCasterAnimation,animName=Skill03; PlayAudio,audioID=8010,audioType=1; Wait,waitTime=450; PlayCasterBindEffect,effectID=3475; Wait,waitTime=2700; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=3476; Wait,waitTime=700; PlaySummonTrap,trapID=PARAM.trapID; "
    }
  }
}
return config, "ID", key
