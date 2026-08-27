local activity_herolite_main = {
  {},
  {
    friendship_addition = {
      [1085] = 50
    },
    hero_id = 1085,
    id = 2,
    task_rule_id = 9903,
    task_rule_title = 9902,
    token_id = 1304
  },
  {
    friendship_addition = {
      [1086] = 50
    },
    hero_id = 1086,
    id = 3,
    task_rule_id = 9905,
    task_rule_title = 9904,
    token_id = 1305
  },
  {
    friendship_addition = {
      [1087] = 50
    },
    hero_id = 1087,
    id = 4,
    task_rule_id = 9907,
    task_rule_title = 9906,
    token_id = 1306
  },
  {
    friendship_addition = {
      [1092] = 50
    },
    hero_id = 1092,
    id = 5,
    task_rule_id = 9909,
    task_rule_title = 9908,
    token_id = 1307
  },
  {
    friendship_addition = {
      [1093] = 50
    },
    hero_id = 1093,
    id = 6,
    task_rule_id = 9911,
    task_rule_title = 9910,
    token_id = 1308
  }
}
local __default_values = {
  daily_ticket_id = 1302,
  friendship_addition = {
    [1083] = 50
  },
  friendship_display = 50,
  hero_id = 1083,
  id = 1,
  medicine_id = 1301,
  medicinemax = 3,
  task_rule_id = 9901,
  task_rule_title = 9900,
  ticket_max = 3,
  token_id = 1303,
  token_stage = 1000
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_herolite_main) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  heroMappping = {
    [1083] = 1,
    [1085] = 2,
    [1086] = 3,
    [1087] = 4,
    [1092] = 5,
    [1093] = 6
  }
}
setmetatable(activity_herolite_main, {__index = __rawdata})
return activity_herolite_main
