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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; "
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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2626,audioType=1; PlaySummonTrap,trapID=16014841; PlaySummonTrap,trapID=16014842; PlaySummonTrap,trapID=16014843; PlayMoveTrap,disappearEffID=160148408,moveDelayTime=200,appearLegacyAnimNames=eff_1601484_atkult01_box,appearEffID=160148406; Wait,waitTime=1800; "
    }
  }
}
return config, "ID", key
