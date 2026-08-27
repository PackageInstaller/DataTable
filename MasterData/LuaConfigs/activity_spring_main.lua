local __rt_1 = {12}
local __rt_2 = {
  21102,
  25001,
  25002,
  25003,
  25004,
  25005
}
local __rt_3 = {-1}
local activity_spring_main = {
  {tech_id = 6},
  {
    activity_id = 24002,
    env_list = {
      11,
      12,
      13,
      14,
      15,
      16
    },
    general_id = 24002,
    hard_level_type = 2,
    id = 2,
    main_stage = 240012,
    pre_para2 = {1706774399},
    tech_id = 12,
    tech_special_branch = 41
  },
  {
    activity_id = 24003,
    brotato_sector = 240032,
    env_list = {
      7,
      8,
      9,
      10
    },
    game_brotato = 2,
    game_music = 1,
    general_id = 24003,
    handbook_type = 2,
    hard_level_type = 3,
    id = 3,
    initial_protocol_all = {
      21200,
      21201,
      21202,
      21203,
      21204,
      21205,
      21206,
      21207
    },
    main_stage = 240031,
    pre_para2 = {1687939200},
    task_time = 1687939200,
    tech_special_branch = 35
  }
}
local __default_values = {
  activity_id = 24001,
  brotato_sector = 0,
  daily_task_refresh_max = 1,
  env_list = {
    1,
    2,
    3,
    4,
    5,
    6
  },
  game_brotato = 0,
  game_music = 0,
  general_id = 24001,
  handbook_type = 1,
  hard_level_type = 1,
  hard_pre_condition = __rt_1,
  hard_rule_id = 4,
  id = 1,
  initial_protocol_all = __rt_2,
  interact_item = 1055,
  main_stage = 240011,
  pre_para1 = __rt_3,
  pre_para2 = {1655971199},
  story_stage = 0,
  task_daily_release = 2,
  task_limit = 8,
  task_rule_id = 9,
  task_time = 1673942400,
  tech_id = 11,
  tech_special_branch = 15,
  ticket_item = 1007
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_spring_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_spring_main, {__index = __rawdata})
return activity_spring_main
