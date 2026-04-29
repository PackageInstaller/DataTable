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
      " Jump,condition=IsAddBloodValueGreaterThan,param=0,result=1,goto=End1; PlayCasterAnimation,animName=Skill01; PlayAudio,audioID = 6039,audioType=1; Wait,waitTime=1500; Wait,waitTime=0,label=End1; "
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
      " Jump,condition=IsAddBloodValueGreaterThan,param=0,result=0,goto=End2; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=1500; PlayAddHpText; Wait,waitTime=0,label=End2; "
    }
  }
}
return config, "ID", key
