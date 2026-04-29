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
      " PlayAudio,audioID = 160237102,audioType=1; PlayCasterBindEffect,effectID =160237106; PlayCasterAnimation,animName = AtkChain; PlayCasterTurnToTargetGrid; PlayPetMoyeChainSkill, yieldTimeScale=1000, flyEffectID=160237107, flyTime=500, flyTrace=1, offsetY=0, isBlock=0, yieldTime=350, centerGridEffectID=160237108, trapIDs=8002371|8002372|8002373|8002374|8062371|8062372|8062373|8062374|8402375|8462375|8502375|8562375; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4002371,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    460,
    {
      "PlayAudio,audioID = 2616,audioType=1;"
    }
  }
}
return config, "ID", key
