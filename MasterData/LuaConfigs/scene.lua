local scene = {
  {
    audio_id = 3330,
    scene_name = "006_Arena_001"
  },
  {
    audio_id = 3102,
    deploy_rows = 2,
    id = 2,
    scene_name = "006_Arena_002",
    size_row = 6
  },
  {
    audio_id = 3101,
    deploy_rows = 2,
    id = 3,
    scene_name = "006_Arena_003",
    size_row = 6
  },
  {
    audio_id = 3103,
    id = 4,
    scene_name = "006_Arena_004"
  },
  {
    audio_id = 3107,
    deploy_rows = 2,
    id = 5,
    scene_name = "006_Arena_000",
    size_row = 6
  },
  {
    audio_id = 3104,
    id = 6,
    scene_name = "006_Arena_005"
  },
  {
    audio_id = 3105,
    id = 7,
    scene_name = "006_Arena_006"
  },
  {
    audio_id = 3104,
    id = 8,
    scene_name = "006_Arena_007"
  },
  {
    audio_id = 3104,
    deploy_rows = 11,
    id = 9,
    scene_name = "006_Arena_TD_000",
    size_col = 7,
    size_row = 11
  },
  {
    audio_id = 3106,
    deploy_rows = 2,
    id = 10,
    scene_name = "006_Arena_008",
    size_row = 6
  },
  {
    audio_id = 3201,
    deploy_rows = 2,
    id = 11,
    size_row = 6
  },
  {
    audio_id = 3108,
    depth_support = true,
    id = 12,
    scene_name = "006_Arena_SE2021_003"
  },
  {
    audio_id = 3105,
    deploy_rows = 11,
    depth_support = true,
    id = 13,
    scene_name = "006_Arena_SE2021_001",
    size_col = 7,
    size_row = 11
  },
  {
    audio_id = 3109,
    id = 14,
    scene_name = "006_Arena_SE2021_002"
  },
  {
    audio_id = 3201,
    depth_support = true,
    id = 15,
    scene_name = "006_Arena_SE2021_003"
  },
  {
    audio_id = 3107,
    id = 16,
    scene_name = "006_Arena_000",
    size_row = 6
  },
  {
    audio_id = 3201,
    id = 17,
    size_row = 6
  },
  {
    audio_id = 3110,
    id = 18,
    scene_name = "006_Arena_012"
  },
  {
    audio_id = 3202,
    id = 19,
    size_row = 6
  },
  {
    audio_id = 3107,
    id = 20,
    scene_name = "006_Arena_000",
    size_row = 6
  },
  {
    audio_id = 3107,
    id = 21,
    scene_name = "006_Arena_000",
    size_row = 6
  },
  {
    audio_id = 3330,
    id = 22,
    scene_name = "006_Arena_007"
  },
  {
    id = 23,
    scene_name = "006_Arena_003_a"
  },
  {
    id = 24,
    scene_name = "006_Arena_014"
  },
  {
    audio_id = 3105,
    deploy_rows = 11,
    depth_support = true,
    grid_scale_factor = 50,
    id = 25,
    scene_name = "Carnival2023_minigame",
    size_col = 17,
    size_row = 22
  },
  {
    audio_id = 3105,
    deploy_rows = 9,
    depth_support = true,
    id = 26,
    scene_name = "006_Arena_016",
    size_col = 7,
    size_row = 10
  },
  {
    depth_support = true,
    id = 27,
    scene_name = "006_Arena_015"
  },
  {
    depth_support = true,
    id = 28,
    scene_name = "006_Arena_017"
  },
  {
    audio_id = 3109,
    id = 29,
    scene_name = "006_Arena_SE2021_005"
  },
  {
    audio_id = 3105,
    deploy_rows = 9,
    depth_support = true,
    id = 30,
    scene_name = "006_Arena_SE2021_005_GA",
    size_col = 7,
    size_row = 10
  },
  {
    id = 31,
    scene_name = "006_Arena_013"
  },
  {
    deploy_rows = 9,
    id = 32,
    scene_name = "006_Arena_013_GA",
    size_col = 7,
    size_row = 10
  },
  {
    id = 33,
    scene_name = "006_Arena_018"
  },
  {
    audio_id = 3458,
    depth_support = true,
    id = 34,
    scene_name = "006_Arena_017"
  },
  {
    audio_id = 3457,
    depth_support = true,
    id = 35,
    scene_name = "006_Arena_017"
  },
  {
    audio_id = 3456,
    id = 36,
    size_row = 6
  },
  {
    depth_support = true,
    id = 37,
    scene_name = "006_Arena_017_1"
  },
  {
    audio_id = 3461,
    id = 38,
    size_row = 6
  },
  {
    audio_id = 3460,
    id = 39,
    size_row = 6
  },
  {
    audio_id = 3463,
    depth_support = true,
    id = 40,
    scene_name = "006_Arena_017"
  }
}
local __default_values = {
  audio_id = 3341,
  deploy_rows = 3,
  depth_support = false,
  grid_scale_factor = 100,
  id = 1,
  scene_name = "006_Arena_010",
  size_col = 5,
  size_row = 7
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(scene) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(scene, {__index = __rawdata})
return scene
