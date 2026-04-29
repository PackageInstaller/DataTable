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
      " Jump,condition=CheckTrapOpenStateChange,result=0,param=1,goto=phaseEnd; PlayCasterBindEffect,effectID=3849; "
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
      " Jump,condition=CheckTrapOpenStateChange,result=0,param=0,goto=phaseEnd; PlayCasterBindEffect,effectID=3850; "
    }
  }
}
return config, "ID", key
