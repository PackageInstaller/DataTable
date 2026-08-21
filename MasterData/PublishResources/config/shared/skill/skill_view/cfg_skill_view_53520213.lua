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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = Atk_l; PlayAudio,audioID = 7004,audioType=1; PlayCasterBindEffect,effectID=1075; Wait,waitTime=400; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=50005,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
