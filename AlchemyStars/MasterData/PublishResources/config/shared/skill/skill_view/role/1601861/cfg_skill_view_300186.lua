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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601551,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    99,
    2,
    1,
    0,
    {
      cameraEffID = 160186109,
      cameraEffAnimOut = "eff_1601861_atkult_camera_out",
      sceneEffID = 160186113,
      sceneEffPos = {x = 5, y = 4},
      sceneEffAnimIn = "eff_1601861_atkult_main_scene_in",
      sceneEffAnimIdle = "eff_1601861_atkult_main_scene_idle",
      sceneEffAnimOut = "eff_1601861_atkult_main_scene_out",
      convertEffID = 160186110,
      convertEffAnimOut = "eff_1601861_atkult_gezi_out",
      beginDelayTime = 500,
      moveSpeedTime = 750,
      moveAnim = "AtkUlt",
      moveTrailEffect = "eff_1601861_atkult_main_fretrail.asset",
      teleportDelayTime = 1000,
      disappearEffID = 160186115,
      disappearTime = 300,
      appearEffID = 160186114,
      appearDelayTime = 250,
      attackAnim = "AtkUlt1",
      gatherEffIDList = {160186108, 160186112},
      attackEffID = 160186111,
      attackEffDelayTime = 800,
      hitAnim = "Hit",
      hitDelayTime = 1000,
      endDelayTime = 900,
      sceneOutDelayTime = 300,
      attackEffTime = 2500,
      startAudioID = 2610,
      convertAudioID = 2611,
      teleportAudioID = 2613,
      attackAudioID = 2612
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
