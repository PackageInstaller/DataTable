local __rt_1 = {3}
local __rt_2 = {1104}
local __rt_3 = {}
local hero_golevel = {
  [909] = {},
  [910] = {
    choose_use_level = 40,
    go_level = 40,
    item_id = 910
  },
  [911] = {
    choose_use_level = 60,
    go_level = 60,
    item_id = 911
  }
}
local __default_values = {
  choose_use_level = 20,
  go_level = 20,
  item_id = 909,
  pre_condition = __rt_1,
  pre_para1 = __rt_2,
  pre_para2 = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_golevel) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(hero_golevel, {__index = __rawdata})
return hero_golevel
