local __rt_1 = {4}
local camp_active_skill = {
  {
    des = 308996,
    use_limit = {1, 3}
  },
  {
    des = 462267,
    id = 2,
    use_limit = {2}
  },
  {id = 3},
  {des = 506307, id = 4},
  {
    des = 430947,
    id = 5,
    use_limit = {1}
  }
}
local __default_values = {
  des = 130500,
  id = 1,
  use_limit = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(camp_active_skill) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(camp_active_skill, {__index = __rawdata})
return camp_active_skill
