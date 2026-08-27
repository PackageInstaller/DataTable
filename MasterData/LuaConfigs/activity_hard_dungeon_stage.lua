local __rt_1 = {
  [25604] = -200
}
local __rt_2 = {
  [20171] = 1,
  [22012] = 5,
  [22015] = 5,
  [22018] = 1,
  [22019] = 1,
  [22020] = 3,
  [22021] = 3,
  [22023] = 2,
  [22024] = 2,
  [22025] = 4,
  [22026] = 4
}
local __rt_3 = {}
local __rt_4 = {
  1,
  2,
  3,
  4,
  5
}
local __rt_5 = {
  1117,
  1123,
  1124,
  1114,
  1125
}
local __rt_6 = {
  [20171] = 0,
  [22012] = 150,
  [22015] = 200,
  [22018] = 0,
  [22019] = 0,
  [22020] = 100,
  [22021] = 100,
  [22023] = 50,
  [22024] = 50,
  [22025] = 100,
  [22026] = 150
}
local activity_hard_dungeon_stage = {
  [49501] = {dungeon_desc = 119014},
  [49502] = {
    assistance_id = 82,
    dungeon_desc = 249210,
    dungeon_id = 49502
  },
  [49503] = {
    assistance_id = 83,
    dungeon_desc = 370685,
    dungeon_id = 49503
  },
  [49504] = {assistance_id = 84, dungeon_id = 49504},
  [49505] = {
    assistance_id = 85,
    dungeon_desc = 438602,
    dungeon_id = 49505
  }
}
local __default_values = {
  assist_buff = __rt_1,
  assistanc_reduce = 150,
  assistance_id = 81,
  buffGroup = __rt_2,
  buffrule_des = 40001,
  buffrule_title = 40000,
  const_buff = __rt_3,
  dungeon_desc = 105314,
  dungeon_id = 49501,
  groupOrder = __rt_4,
  group_name = __rt_5,
  init_buff_id = __rt_6,
  level_pic = "small_4"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hard_dungeon_stage) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_hard_dungeon_stage, {__index = __rawdata})
return activity_hard_dungeon_stage
