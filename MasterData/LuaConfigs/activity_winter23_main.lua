local __rt_1 = {12}
local activity_winter23_main = {
  {tech_id = 7},
  [3] = {
    extra_obj_unlock = {250031129, 250032129},
    farm_stage_id = {
      250031102,
      250031107,
      250031113,
      250031114,
      250031119,
      250031122,
      250032102,
      250032107,
      250032113,
      250032114,
      250032119,
      250032122
    },
    game_penguin = 5,
    hard_stage = 250031,
    id = 3,
    normal_sector = 250032,
    second_pre_para1 = {1711612800},
    second_pre_para2 = {1712822399},
    shop_list = {
      1052,
      1053,
      1054,
      1055
    },
    tech_special_branch = 44,
    token_item = 1098,
    warchess_season_id = 6
  }
}
local __default_values = {
  extra_obj_unlock = {250011129, 250012129},
  farm_stage_arrange = 15,
  farm_stage_id = {
    250011102,
    250011107,
    250011113,
    250011114,
    250011119,
    250011122,
    250012102,
    250012107,
    250012113,
    250012114,
    250012119,
    250012122
  },
  first_avg = 2500101,
  game_penguin = 4,
  hard_stage = 250011,
  id = 1,
  normal_sector = 250012,
  second_main_stage = 140011108,
  second_pre_condition = __rt_1,
  second_pre_para1 = {1678953600},
  second_pre_para2 = {1680163199},
  shop_list = {
    1040,
    1041,
    1042,
    1043
  },
  task_rule_id = 7,
  tech_id = 13,
  tech_item = 1223,
  tech_special_branch = 18,
  ticket_item = 1007,
  token_item = 1062,
  warchess_guide_sector = 220012,
  warchess_season_id = 3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_winter23_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_winter23_main, {__index = __rawdata})
return activity_winter23_main
