local __rt_1 = {426972, 426972}
local __rt_2 = {100, 100}
local __rt_3 = {1002}
local __rt_4 = {350}
local __rt_5 = {}
local __rt_6 = {1060}
local activity_white_day = {
  {task_title = 382309},
  {
    activity_avg = 1200201,
    album_title = 7213,
    endless_task_title = 414270,
    finish_avg = 1200202,
    game_2048 = 3,
    id = 2,
    scene = "010_Event_002",
    sector_id = 120021,
    skinFirstCostIds = __rt_3,
    skinFirstCostNums = {0},
    speed_shop = 1101,
    tips = 24
  },
  {
    album_title = 7216,
    exchange_tokenId = 1059,
    game_2048 = 4,
    id = 3,
    price_origin = "1060=280",
    random_tokenId = 1058,
    sector_id = 120031,
    skinCostIds = __rt_6,
    skinCostNums = {240},
    skinOrgCostIds = __rt_6,
    skinOrgCostNums = {280},
    skin_rule = 13,
    speed_shop = 1102,
    task_title = 307596,
    tips = 35
  }
}
local __default_values = {
  activity_avg = 1200101,
  album_content = 7206,
  album_title = 7207,
  assist_rule = 5,
  endless_limit_des = __rt_1,
  endless_limit_task = __rt_2,
  endless_task_title = 199675,
  exchange_des = 84506,
  exchange_tokenId = 1029,
  exchange_tokenNum = 1,
  finish_avg = 1200102,
  game_2048 = 1,
  id = 1,
  price_origin = "",
  random_des = 221734,
  random_tokenId = 1028,
  random_tokenNum = 1,
  rule_content = 7015,
  rule_title = 7014,
  scene = "010_Event_001",
  sector_id = 120011,
  skinCostIds = __rt_3,
  skinCostNums = __rt_4,
  skinFirstCostIds = __rt_5,
  skinFirstCostNums = __rt_5,
  skinOrgCostIds = __rt_5,
  skinOrgCostNums = __rt_5,
  skin_rule = 6,
  speed_shelve = 1,
  speed_shop = 1100,
  speed_ticket = 1030,
  task_title = 106703,
  tips = 16
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_white_day) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_white_day, {__index = __rawdata})
return activity_white_day
