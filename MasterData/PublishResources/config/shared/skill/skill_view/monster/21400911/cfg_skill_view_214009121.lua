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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3083,audioType=1; PlayCasterBindEffect,effectID =1772; PlayCasterBindEffect,effectID =1774; PlaySelectGridEffect,effectID =1773,intervalTime=0; Wait,waitTime=4800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2800,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID1,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID2; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
