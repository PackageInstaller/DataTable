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
      " PlayCasterAnimation,animName = Atk3; PlayAudio,audioID =290580101,audioType=1; PlayCasterMaterialAnim,animName=effani_2906401_skill03_mat; Wait,waitTime=250; PlayCasterBindEffect,effectID=290640101; PlayCasterAddBuff,buffID=1119084; "
    }
  }
}
return config, "ID", key
