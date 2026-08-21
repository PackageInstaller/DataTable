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
local common = {
  {"", "1,0"}
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
      "PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =2325; PlayAudio,audioID = 2222; "
    },
    common[1]
  },
  {
    2,
    2,
    78,
    2,
    1,
    1600,
    {
      effectID = 2326,
      intervalTime = 0,
      effectScale = 1,
      downDisance = 1,
      doNotHideTarget = 1,
      waitDownTime = 0,
      downTime = 800,
      waitTime = 0,
      upTime = 100,
      waitDamageTime = 0,
      hitEffectID = 0,
      hitAnimName = "Hit"
    },
    common[1]
  },
  {
    3,
    3,
    0,
    2,
    2,
    300,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=410094,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
