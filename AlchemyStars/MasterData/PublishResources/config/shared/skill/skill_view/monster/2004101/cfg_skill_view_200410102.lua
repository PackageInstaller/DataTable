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
      " PlayCasterTurnToTarget; PlayAudio,audioID = 200900102,audioType=1; PlayCasterAnimation,animName = skill02; PlayCasterBindEffect,effectID=200410101; Wait,waitTime=700; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=200410102,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
