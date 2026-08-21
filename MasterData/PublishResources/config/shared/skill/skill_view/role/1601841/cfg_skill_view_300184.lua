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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601841,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    98,
    2,
    1,
    0,
    {
      startAction = "AtkUlt",
      startDashDelay = 100,
      startEffectID = 160184104,
      middleStartAction = "AtkUlt2",
      middleStartDashDelay = 150,
      stopAction = "AtkUlt3",
      stopDealy = 1400,
      dashAudioID = 2594,
      dashAction = "AtkUlt1",
      eachDashDuration = 250,
      pathPointEffectID = 160184105,
      eachDashFinishEffectID = 160184106,
      dashEffectID = 160184107
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    500,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
