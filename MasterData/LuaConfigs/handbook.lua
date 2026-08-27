local __rt_1 = {3}
local __rt_2 = {2101}
local __rt_3 = {}
local handbook = {
  {title_en = 270199},
  {
    id = 2,
    title = 185966,
    title_en = 468724
  },
  {
    collect_bar = false,
    id = 3,
    title = 72531,
    title_en = 507903
  },
  {
    id = 4,
    pre_para1 = {2115},
    title = 23041
  }
}
local __default_values = {
  collect_bar = true,
  id = 1,
  is_hide = false,
  pre_condition = __rt_1,
  pre_para1 = __rt_2,
  pre_para2 = __rt_3,
  title = 180334,
  title_en = "Sporadic Battlefield"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(handbook) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(handbook, {__index = __rawdata})
return handbook
