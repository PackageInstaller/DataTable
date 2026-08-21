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
      " ReplacePrefabByUnderGrid,redPrefab=gezi_lingjing_red.prefab,yellowPrefab=gezi_lingjing_yellow.prefab,bluePrefab=gezi_lingjing_blue.prefab,greenPrefab=gezi_lingjing_green.prefab,anyPrefab=gezi_lingjing_any.prefab; "
    }
  }
}
return config, "ID", key
