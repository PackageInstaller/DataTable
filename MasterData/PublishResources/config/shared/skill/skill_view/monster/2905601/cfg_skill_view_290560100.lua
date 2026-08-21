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
      " PlayAudio,audioID=290560101,audioType=1; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName=Birth; PlayCameraEffect,effectID=290560100; PlayCasterBindEffect,effectID =290560101; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=4500; PlayCasterHUDVisible,visible=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=29056014; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
