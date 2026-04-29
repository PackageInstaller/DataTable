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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1601121,waitTime = 2000;"
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
      " PlayAudio,audioID = 2343,audioType=1;"
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayGridDark,darkType=0; PlaySelectCenterGridEffect; PlayCameraEffect, effectID=3059; PlayTurnToPickUpDirection; PlayCasterAnimation,animName = AtkUlt; PlayDeerActiveSkillEffect; PlayCasterBindEffect,effectID =2928; Wait,waitTime=300; PlayTeleportAsMoving,time=1500; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      "PlayCasterBindEffect,effectID=2929; Wait,waitTime=1000; PlayAllGridPurify; PlaySummonTrap,trapID=14; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
