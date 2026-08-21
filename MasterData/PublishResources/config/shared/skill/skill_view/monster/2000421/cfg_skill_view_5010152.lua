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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = Skill01; Wait,waitTime=700; PlayAudio,audioID = 7004,audioType=1; PlayCasterBindEffect,effectID=1075; Wait,waitTime=100; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=500051,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
