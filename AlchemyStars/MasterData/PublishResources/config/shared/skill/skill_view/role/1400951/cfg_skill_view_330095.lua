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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID =1400951,waitTime =2000; "
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
      " PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=2363; PlayAudio,audioID = 2230,audioType=1; Wait,waitTime=2500; PlayCasterVisible,visible=0; PlayTeamHUDVisible,visible=0; DataSelectPickupGrid,gridIndex=1; PlaySelectCenterGridEffect,effectID=2360,intervalTime=0; Wait,waitTime=1500; PlaySummonTrap,trapID=14009516,effectID=0; PlaySummonTrap,trapID=14009514,effectID=0; PlayCasterVisible,visible=1; PlayTeamHUDVisible,visible=1; PlayCasterAnimation,animName=AtkUltb01; Wait,waitTime=100; PlayCasterBindEffect,effectID=2364; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
