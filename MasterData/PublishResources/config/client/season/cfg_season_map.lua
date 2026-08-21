local key = {
  ID = 1,
  MapRes = 2,
  Zones = 3,
  Modes = 4,
  OpenMapIDs = 5,
  MiniMapRes = 6,
  Line = 7,
  MapDragRange = 8,
  ClickEffectAnim = 9,
  LeftUpAnchorPos = 10,
  RightDownAnchorPos = 11,
  MapScale = 12,
  Mode = 13,
  CloseMapID = 14,
  ClickEffect = 15,
  ModeUnlock = 16,
  DefaultSceneEffect = 17
}
local common = {
  "eff_scene_daohangxian.prefab",
  "eff_Scene_yd_ludian.prefab",
  "S5_pfb_daohangxian.prefab",
  "S5_pfb_yd_ludian.prefab",
  {1},
  {
    1,
    2,
    3,
    4
  },
  {1, 2},
  {
    4,
    -4,
    -30,
    22
  },
  {
    4.5378,
    0,
    -4.5043
  },
  {
    -31.56395,
    0,
    22.46021
  },
  {
    4.5,
    -4.5,
    -31.5,
    22.5
  },
  {
    [2] = "eff_Scene_ydludian_in",
    [3] = "eff_Scene_ydludian_loop"
  }
}
local config = {
  [8001] = {
    8001,
    "SeasonSceneS1",
    {
      1,
      2,
      3
    },
    common[5],
    {1, 3},
    "s1_map_small",
    common[1],
    common[8],
    common[12],
    {
      4.612,
      0,
      -4.563
    },
    {
      -31.4314,
      0,
      22.466
    },
    0.6,
    0,
    2,
    common[2]
  },
  [8002] = {
    8002,
    "SeasonSceneS2",
    common[6],
    common[7],
    common[5],
    "N5_map_small",
    common[1],
    common[8],
    common[12],
    {
      6.7078,
      0,
      -10.9876
    },
    {
      -32.5479,
      0,
      28.2679
    },
    0.6,
    1,
    nil,
    common[2],
    {
      [2] = "8002035,2|8002035,3"
    }
  },
  [8003] = {
    8003,
    "SeasonSceneS3",
    common[6],
    common[7],
    common[5],
    "s3_small_map",
    "s3_pfb_yd_daohangxian.prefab",
    common[8],
    {
      [2] = "S3_eff_Scene_yd_ludian_in",
      [3] = "S3_eff_Scene_yd_ludian_loop"
    },
    {
      4.15,
      0,
      -8.989
    },
    {
      -31.15,
      0,
      26.81
    },
    0.6,
    1,
    nil,
    "s3_pfb_yd_ludian.prefab",
    {
      [2] = "8003029,2|8003029,3"
    }
  },
  [8004] = {
    8004,
    "SeasonSceneS4",
    common[6],
    common[7],
    common[5],
    "s4_small_map",
    common[1],
    common[8],
    common[12],
    common[9],
    common[10],
    0.6,
    1,
    nil,
    common[2],
    {
      [2] = "8004031,2|8004031,3"
    }
  },
  [8005] = {
    8005,
    "SeasonSceneS5",
    common[5],
    common[7],
    common[5],
    "s5_small_map",
    common[3],
    common[11],
    common[12],
    common[9],
    common[10],
    0.6,
    1,
    nil,
    common[4]
  },
  [8006] = {
    8006,
    "SeasonSceneS6",
    common[5],
    common[7],
    common[5],
    "s6_small_map",
    common[3],
    common[11],
    common[12],
    common[9],
    common[10],
    0.6,
    1,
    nil,
    common[4]
  },
  [8007] = {
    8007,
    "SeasonSceneS7",
    common[5],
    common[7],
    common[5],
    "s7_small_map",
    common[3],
    common[11],
    common[12],
    common[9],
    common[10],
    0.6,
    1,
    nil,
    common[4],
    nil,
    {
      "S7_envpfb_eff_smoke"
    }
  },
  [8008] = {
    8008,
    "SeasonSceneS8",
    common[5],
    common[7],
    common[5],
    "s8_small_map",
    common[3],
    common[11],
    common[12],
    common[9],
    common[10],
    0.6,
    1,
    nil,
    common[4]
  }
}
return config, "ID", key
