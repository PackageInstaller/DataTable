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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=200520101,audioType=1; PlayCasterMaterialAnim,animName=eff_2005201_skill01_main; Wait,waitTime=600; PlayCasterBindEffect,effectID= 200520101; Wait,waitTime=2000; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20052011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
