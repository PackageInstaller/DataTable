local activity_winter = {
  {},
  {
    activity_tech_type = 4,
    defeat_jump = {5, 4},
    hard_pre_condition = {7},
    id = 2,
    main_sector = 110012,
    point_tech = 40031,
    pre_para1 = {28105},
    pre_para2 = {1},
    remaster_id = 1,
    remaster_store_info = 15004,
    remaster_store_jump = 1038,
    remaster_store_jump_icon = "Icon_item",
    shop_list = {
      2011,
      2012,
      2013
    },
    task_list = {
      6116,
      6117,
      6118,
      6119,
      6120,
      6121,
      6122,
      6123,
      6124,
      6125,
      6126,
      6127,
      6128,
      6129,
      6130
    }
  }
}
local __default_values = {
  activity_tech_type = 1,
  cost_id = 1026,
  defeat_jump = {3, 4},
  first_avg = 15,
  hard_chip_num = 1,
  hard_level_type = 2,
  hard_pre_condition = {12, 7},
  id = 1,
  level_type = 1,
  main_sector = 110011,
  point = 1025,
  point_tech = 10031,
  pre_para1 = {1643270400, 28005},
  pre_para2 = {-1, 1},
  remaster_id = 0,
  remaster_store_info = 0,
  remaster_store_jump = 0,
  remaster_store_jump_icon = "",
  shop_list = {
    1011,
    1012,
    1013
  },
  task_list = {
    6016,
    6017,
    6018,
    6019,
    6020,
    6021,
    6022,
    6023,
    6024,
    6025,
    6026,
    6027,
    6028,
    6029,
    6030,
    6031,
    6032,
    6033,
    6034,
    6035
  },
  token = 1024
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_winter) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_winter, {__index = __rawdata})
return activity_winter
