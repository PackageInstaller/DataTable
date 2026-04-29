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
      " Jump,condition=CheckTrapOpenStateChange,result=0,param=1,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850|3851; PlayCasterBindEffect,effectID=3852; "
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
      " Jump,condition=CheckTrapOpenStateChange,result=0,param=0,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850|3851; PlayCasterBindEffect,effectID=3853; "
    }
  }
}
return config, "ID", key
