local dorm_interpoint = {
  {
    anime_type = 0,
    exit_curve = 3,
    interact_name = 43784,
    interact_point_type = 1,
    move_curve = 1
  },
  {
    anime_type = 0,
    exit_curve = 4,
    id = 2,
    interact_front = 1,
    move_curve = 2
  },
  {
    anime_type = 0,
    exit_curve = 1,
    id = 3,
    interact_name = 170787,
    interact_point_type = 3,
    move_curve = 1
  },
  {
    anime_type = 0,
    exit_curve = 4,
    id = 4,
    interact_front = 2,
    move_curve = 2
  },
  {
    anime_type = 0,
    exit_curve = 3,
    id = 5,
    interact_front = 3,
    interact_name = 43784,
    interact_point_type = 1,
    move_curve = 1
  },
  {
    anime_type = 0,
    exit_curve = 3,
    id = 6,
    interact_front = 1,
    interact_name = 43784,
    interact_point_type = 1,
    move_curve = 1
  },
  {
    anime_type = 0,
    exit_curve = 4,
    id = 7,
    move_curve = 2
  },
  {
    anime_type = 0,
    exit_curve = 4,
    id = 8,
    interact_front = 3,
    is_reverse = true,
    move_curve = 2
  },
  {
    anime_type = 0,
    exit_curve = 3,
    id = 9,
    interact_front = 2,
    interact_name = 43784,
    interact_point_type = 1,
    move_curve = 1
  },
  {
    bind_path = "etj2018_deco_005/root/Bone001/Bone002/bind_path",
    id = 10,
    interact_name = 62837,
    interact_point_type = 4
  },
  {
    bind_path = "etj2018_deco_004/root/Bone007/Bone008/bind_path",
    id = 11,
    interact_name = 334666,
    interact_point_type = 5
  },
  {
    bind_path = "etj2018_deco_011/root/Bone002/bind_path",
    id = 12,
    interact_name = 58042,
    interact_point_type = 6
  },
  {
    bind_path = "etj2018_deco_009/root/Bone001/Bone002/bind_path",
    id = 13,
    interact_name = 62837,
    interact_point_type = 7
  },
  {
    bind_path = "srt2022_drumset/root/Bone021/bind_path",
    id = 14,
    interact_audio_id = 72015214,
    interact_name = 511809,
    interact_point_type = 8
  },
  {
    bind_path = "dwc2022_deco_04/root/bind_path",
    id = 15,
    interact_name = 228964,
    interact_point_type = 9
  },
  {
    bind_path = "dwc2022_deco_05/root/bind_path",
    id = 16,
    interact_name = 46096,
    interact_point_type = 10
  },
  {
    bind_path = "dwc2022_table_01/root/bind_path",
    id = 17,
    interact_name = 228964,
    interact_point_type = 11
  },
  {
    bind_path = "dwc2022_table_02/root/bind_path",
    id = 18,
    interact_name = 355113,
    interact_point_type = 12
  },
  {
    bind_path = "anniversary1_bar/root/bind_path",
    id = 19,
    interact_name = 374521,
    interact_point_type = 13
  },
  {
    bind_path = "anniversary2_table/anniversary2_table_root/bind_path",
    id = 20,
    interact_name = 374521,
    interact_point_type = 14
  },
  {
    bind_path = "anniversary3_pool/anniversary3_pool_root/Bone001/bind_path",
    id = 21,
    interact_name = 374521,
    interact_point_type = 15
  },
  {
    bind_path = "anniversary4_chair/root/bind_path",
    id = 22,
    interact_name = 374521,
    interact_point_type = 16
  },
  [1007] = {
    anime_type = 0,
    exit_curve = 4,
    id = 1007,
    is_reverse = true,
    move_curve = 2
  }
}
local __default_values = {
  anime_type = 1,
  bind_path = "",
  exit_curve = 0,
  id = 1,
  interact_audio_id = 0,
  interact_front = 0,
  interact_name = 266043,
  interact_point_type = 2,
  is_exclusive = true,
  is_reverse = false,
  move_curve = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_interpoint) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_interpoint, {__index = __rawdata})
return dorm_interpoint
