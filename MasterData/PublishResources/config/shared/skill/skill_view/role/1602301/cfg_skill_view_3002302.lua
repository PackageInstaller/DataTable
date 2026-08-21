local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401371,waitTime = 2000;"
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
      " PlayAudio,audioID = 160230105,audioType=1; PlayCasterAnimation,animName=AtkUlt1; PlayCasterMaterialAnim,animName=effanim_1602301_atkult_b01_mat; PlayCasterBindEffect,effectID=160230110; Wait,waitTime=2600; PlayCameraEffect,effectID=160230113; PlaySwapSan2TeamHp; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
