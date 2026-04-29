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
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1717; PlayAudio,audioID = 3052,audioType=1; Wait,waitTime=3000; DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=1718,label=playRangeEffect; Wait,waitTime=2000; PlaySummonTrap,trapID=2003; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
