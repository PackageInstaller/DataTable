local __rt_1 = {12}
local __rt_2 = {1663228800}
local __rt_3 = {1665647999}
local __rt_4 = {
  0,
  1000,
  2000,
  3000,
  5000
}
local __rt_5 = {
  1.5,
  0.6,
  1.0
}
local __rt_6 = {
  47,
  51,
  38,
  39,
  40,
  42
}
local activity_summer_main = {
  {tech_id = 3},
  {
    game_snake = 2,
    guide_id = 49,
    hard_rank1 = {140031128, 35},
    hard_rank2 = {140031127, 36},
    id = 2,
    main2nd_id = 140031108,
    main_sector = 140031,
    return_id = 1,
    shop_list = {
      2034,
      2035,
      2036,
      2037
    }
  }
}
local __default_values = {
  bg_video = "sum22_bg",
  daily_task_refresh_max = 1,
  farm_level_condition = __rt_1,
  farm_pre_para1 = __rt_2,
  farm_pre_para2 = __rt_3,
  first_avg = 20,
  game_snake = 1,
  guide_id = 26,
  hard_pre_condition = __rt_1,
  hard_pre_para1 = __rt_2,
  hard_pre_para2 = __rt_3,
  hard_rank1 = {140011128, 19},
  hard_rank2 = {140011127, 20},
  hard_rule_id = 0,
  id = 1,
  main2nd_id = 140011108,
  main2nd_start = 1662019200,
  main_sector = 140011,
  point_tech_number = 20000,
  refresh_item = 1003,
  refresh_max_tips = 7501,
  refresh_price = __rt_4,
  return_id = 0,
  scale_zoom = __rt_5,
  shop_list = {
    1034,
    1035,
    1036,
    1037
  },
  story_stage = 140012,
  task_limit = 4,
  task_rule_id = 7,
  tech_des_sort = __rt_6,
  tech_id = 10,
  tech_item = 1204,
  ticket_item = 1203,
  token_item = 1202
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_summer_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_summer_main, {__index = __rawdata})
return activity_summer_main
