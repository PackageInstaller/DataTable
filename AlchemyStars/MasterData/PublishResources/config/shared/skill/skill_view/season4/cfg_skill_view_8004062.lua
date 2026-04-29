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
      " PlayAudio,audioID=290620104,audioType=1; PlayCasterLegacyAnimation,animNames=eff_2906201_passive02_gezi_out|eff_2906201_passive02_gezi_in; PlayFixTrapWall; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=80041801,remove=1; PlayTargetAddBuff,buffID=80041802,remove=1; PlayTargetAddBuff,buffID=80041803,remove=1; PlayTargetAddBuff,buffID=80041804; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
