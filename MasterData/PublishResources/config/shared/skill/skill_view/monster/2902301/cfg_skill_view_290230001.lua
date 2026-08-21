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
      " PlayCasterVisible,visible=0; PlayTargetAddBuff,buffID=29023031; PlayCasterBindEffect,effectID=3607; PlayCasterBindEffect,effectID=3608; PlayCasterMaterialAnim,animName=eff_2602301_birth; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayAudio,audioID = 6187,audioType=1; Wait,waitTime=400; PlayCasterAnimation,animName=Birth; Wait,waitTime=1100; StopCasterMaterialAnim,animName=eff_2602301_birth; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
