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
      " PlayCasterLegacyAnimation,animNames=effanim_28019001_skill; PlayAudio,audioID =8016,audioType=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=280190114,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; DataSelectBuff,buffIndex=2; PlayTargetAddBuff,buffID=280190115,label=Again; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=Again; DataSelectBuff,buffIndex=3; PlayTargetAddBuff,buffID=280190116,label=doA; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doA; "
    }
  }
}
return config, "ID", key
