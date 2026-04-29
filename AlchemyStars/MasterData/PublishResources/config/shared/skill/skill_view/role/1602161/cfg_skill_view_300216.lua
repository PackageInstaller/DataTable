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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1602161,waitTime = 2000; "
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
      " PlayAudio,audioID = 160216104,audioType=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=160216111; PlayCasterBindEffect,effectID=160216112; PlayCreateAurasTrapByPickUp,trapID=16021611, trapEffDelay=500, trapEffID=160216113, trapAnimNames=eff_1602161_ault_gezi_in|eff_1602161_ault_gezi_loop, flyStartOffset=1, flyRotateOffset=0.3, flyStartHeight=1, flyEffDelay=900, flyEffID=160216114, flyTotalTime=1000, Wait,waitTime=800; PlayGridDark,darkType=1; "
    }
  }
}
return config, "ID", key
