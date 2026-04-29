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
      " PlayAudio,audioID = 6010,audioType=1; Wait,waitTime=400; PlayCasterAnimation,animName = Awake; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1000; PlayAddDarkCameraValue,addValue=0.15; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayAddBuffView,buffID=2000576; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
