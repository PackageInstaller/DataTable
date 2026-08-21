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
      " PlayCasterRenderState,renderState=1; PlayCasterBindEffect,effectID =959; PlayCasterBindEffect,effectID =961; PlayCasterAnimation,animName = Skill01R; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    800,
    {
      "PlayAudio,audioID =6052,audioType=1; PlayCasterBindEffect,effectID =960; "
    }
  },
  {
    3,
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
    4,
    4,
    23,
    1,
    1,
    1500,
    {showtime = 100}
  },
  {
    5,
    5,
    33,
    1,
    1,
    2000,
    {
      anim = "Skill02R",
      delay = 0,
      effIds = {962}
    }
  },
  {
    6,
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
    7,
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
