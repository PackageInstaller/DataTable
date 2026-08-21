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
      "PlayAddBuffResultAll;"
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlaySceneObjLegacyAnimation,sceneObjName=eff_Scene_ymck_boss1,animNames=eff_scene_ymck_idle_to_ult; "
    }
  }
}
return config, "ID", key
