local delivery_attribute = {
  {}
}
local __default_values = {
  acceleration = 99,
  capacity_buff = {2, 3},
  capacity_percentage = {75, 100},
  drag = 10,
  id = 1,
  max_capacity = 8,
  max_move_speed = 2.5,
  run_buff = 1,
  run_cd = 8
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_attribute) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_attribute, {__index = __rawdata})
return delivery_attribute
