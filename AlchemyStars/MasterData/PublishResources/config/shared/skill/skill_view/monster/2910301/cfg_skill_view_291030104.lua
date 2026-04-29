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
      " PlayCasterAnimation,animName=Atk2; PlayCasterBindEffect,effectID =291030101; PlayCasterVisible,visible=1; PlayAudio,audioID=6275,audioType=1; Wait,waitTime=1200; "
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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=291030101; PlayTargetAddBuff,buffID=291030101; PlayTargetAddBuff,buffID=291030102; PlayTargetAddBuff,buffID=291030102; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
