local __rt_1 = {}
local activity_carnival23_main = {
  {
    activity_id = 1201,
    brotato_sector = 330013,
    extra_obj_unlock = {330011102, 330012102},
    game_brotato = 1,
    second_pre_para1 = {1685001600},
    second_pre_para2 = {1687334399}
  },
  {
    brotato_sector = 330123,
    extra_obj_unlock = {330121102, 330122102},
    first_avg = 3302100,
    game_brotato = 5,
    hard_stage = 330121,
    id = 2,
    normal_sector = 330122,
    shop_list = {
      2053,
      2054,
      2055,
      2056
    },
    token_item = 1099
  },
  {
    activity_id = 1202,
    first_avg = 3303100,
    hard_stage = 330031,
    id = 3,
    normal_sector = 330032,
    shop_list = {
      1048,
      1049,
      1050,
      1051
    },
    token_item = 1075
  },
  {
    first_avg = 3305100,
    hard_stage = 330051,
    id = 4,
    normal_sector = 330052,
    shop_list = {
      2060,
      2061,
      2062,
      2063
    },
    token_item = 1100
  },
  {
    extra_stage = 330063,
    first_avg = 3306100,
    hard_stage = 330061,
    id = 5,
    normal_sector = 330062,
    shop_list = {
      1056,
      1057,
      1058,
      1059
    },
    token_item = 1270
  }
}
local __default_values = {
  activity_id = 0,
  brotato_sector = 0,
  extra_obj_unlock = __rt_1,
  extra_stage = 0,
  farm_stage_arrange = 15,
  first_avg = 3300100,
  game_brotato = 0,
  hard_stage = 330011,
  id = 1,
  normal_sector = 330012,
  second_pre_para1 = __rt_1,
  second_pre_para2 = __rt_1,
  shop_list = {
    1044,
    1045,
    1046,
    1047
  },
  ticket_item = 1007,
  token_item = 1066
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival23_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_carnival23_main, {__index = __rawdata})
return activity_carnival23_main
