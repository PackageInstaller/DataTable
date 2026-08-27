local __rt_1 = {}
local background = {
  [500001] = {
    name = 436820,
    src_id_mat_day = "Scene_Day",
    src_id_mat_night = "Scene_Night"
  },
  [500002] = {
    id = 500002,
    pre_condition = {2},
    pre_para1 = {9000},
    src_id_mat_day = "Scene_Warfare",
    src_id_mat_night = "Scene_Warfare",
    src_id_pic_prefab = "WarfareEffect"
  },
  [500003] = {
    id = 500003,
    name = 434629,
    pre_condition = {7},
    pre_para1 = {29010},
    pre_para2 = {1},
    src_id_mat_day = "SceneNew_Day",
    src_id_mat_night = "SceneNew_Night",
    src_id_pic_day = "T_New0414_day",
    src_id_pic_night = "T_New0414_day",
    stop_mesh = "CommandCentre_StopMesh"
  },
  [500004] = {
    condition = 2301,
    condition_para = {20001},
    id = 500004,
    name = 78571,
    src_id_mat_day = "SceneSeabeach_Day",
    src_id_mat_night = "SceneSeabeach_Night",
    src_id_pic_day = "T_SceneSeabeach_Day",
    src_id_pic_night = "T_SceneSeabeach_Day"
  },
  [500005] = {
    condition = 2301,
    condition_para = {25001},
    id = 500005,
    name = 48060,
    src_id_mat_day = "SceneWinter_Day",
    src_id_mat_night = "SceneWinter_Night",
    src_id_pic_day = "T_Scenewinter_day",
    src_id_pic_night = "T_Scenewinter_day"
  },
  [500006] = {
    condition = 2301,
    condition_para = {40001},
    id = 500006,
    name = 378586,
    src_id_pic_day = "T_autumn_day",
    src_id_pic_night = "T_autumn_day"
  }
}
local __default_values = {
  background_locked = false,
  condition = 0,
  condition_para = __rt_1,
  id = 500001,
  name = 352304,
  order = 0,
  pre_condition = __rt_1,
  pre_para1 = __rt_1,
  pre_para2 = __rt_1,
  src_id_mat_day = "SceneAutumn_Day",
  src_id_mat_night = "SceneAutumn_Night",
  src_id_pic_day = "T_Scene_day",
  src_id_pic_night = "T_Scene_day",
  src_id_pic_prefab = "",
  stop_mesh = "FXMesh_stop"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(background) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(background, {__index = __rawdata})
return background
