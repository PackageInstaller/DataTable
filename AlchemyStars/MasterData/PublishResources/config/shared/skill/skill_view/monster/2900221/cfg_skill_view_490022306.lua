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
    0,
    0,
    0,
    {
      " PlayCasterRenderState,renderState=1; PlayCasterBindEffect,effectID =952; PlayCasterBindEffect,effectID =954; PlayAudio,audioID = 6050,audioType=1; PlayCasterAnimation,animName = Skill01L; "
    }
  },
  {
    2,
    3,
    30,
    1,
    1,
    1000,
    {
      gridEffectID = 0,
      bestEffectTime = 500,
      finishDelayTime = 1000
    }
  },
  {
    3,
    4,
    23,
    1,
    1,
    1500,
    {showtime = 100}
  },
  {
    4,
    5,
    33,
    1,
    1,
    2566,
    {
      anim = "Skill02L",
      delay = 0,
      effIds = {953}
    }
  },
  {
    5,
    6,
    0,
    2,
    4,
    500,
    {
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  },
  {
    6,
    7,
    0,
    2,
    4,
    500,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
