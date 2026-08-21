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
      " PlayCasterAnimation,animName =skill02; PlayAudio,audioID = 7052,audioType=1; PlayCasterBindEffect,effectID=200310104; PlayCasterMaterialAnim,animName=eff_2003101_skill02; Wait,waitTime=550; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=5395007; PlayTargetAddBuff,buffID=200310104; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; PlayTargetBindEffect,effectID=200310105; Wait,waitTime=850; "
    }
  }
}
return config, "ID", key
