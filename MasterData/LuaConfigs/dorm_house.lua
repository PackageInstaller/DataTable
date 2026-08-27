local dorm_house = {
  {
    default_room = 1,
    dorm_effect = "FX/Scene/DormScenes/ZS_Prefab_line",
    house_roomtype = 0,
    icon_index = 0,
    order_id = 1,
    unlock_level = 1,
    unlock_logic = 1
  },
  {
    id = 2,
    name = 465279,
    order_id = 10,
    type = 0,
    unlock_level = 1,
    unlock_logic = 1
  },
  {
    default_room = 1,
    dorm_effect = "",
    house_roomtype = 0,
    icon_index = 0,
    id = 3,
    name = 70400,
    type = 2,
    unlock_para = "1001=100"
  },
  {
    id = 4,
    name = 156443,
    order_id = 11,
    type = 0,
    unlock_item_id = 908,
    unlock_item_num = 1
  },
  {
    id = 5,
    is_hide = true,
    name = 246966,
    order_id = 12,
    unlock_house_before = 4,
    unlock_para = "908=1"
  },
  {
    id = 6,
    is_hide = true,
    name = 245860,
    order_id = 13,
    unlock_house_before = 5,
    unlock_para = "908=1"
  },
  {
    default_room = 1,
    dorm_effect = "FX/Scene/DormScenes/ZS_Prefab_line",
    house_roomtype = 0,
    icon_index = 0,
    id = 7,
    name = 206410,
    order_id = 2,
    unlock_level = 1,
    unlock_logic = 1
  }
}
local __default_values = {
  comfort_limit = 99999,
  default_room = 2,
  dorm_effect = "FX/Scene/DormScenes/ZS_Prefab_nothing",
  house_roomtype = 1,
  icon_index = 1,
  id = 1,
  is_hide = false,
  name = 13334,
  order_id = 0,
  type = 1,
  unlock_house_before = 0,
  unlock_logic = 2,
  unlock_para = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_house) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  dmHouseUnlockItemIdDic = {
    [908] = true
  },
  dmHouseUnlockPreHouseIdDic = {},
  id_sort_list = {
    1,
    2,
    4,
    7
  }
}
setmetatable(dorm_house, {__index = __rawdata})
return dorm_house
