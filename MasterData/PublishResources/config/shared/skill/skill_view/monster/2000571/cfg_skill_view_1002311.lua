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
      " PlayCasterAnimation,animName = Death; PlayAudio,audioID = 6008,audioType=1; Wait,waitTime=1000; StopCasterMaterialAnim,animName=eff_2000571_line_01; StopCasterMaterialAnim,animName=eff_2000571_line_02; StopCasterMaterialAnim,animName=eff_2000571_line_03; StopCasterMaterialAnim,animName=eff_2000571_line_04; PlayClearDarkCameraValue; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=2000576,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
