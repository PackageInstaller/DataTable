local delivery_interact_entity = {
  {interact_param = 1},
  {interact_id = 2, interact_param = 2},
  {interact_id = 3, interact_type = 2},
  {interact_id = 4, interact_type = 3},
  [100] = {interact_id = 100, interact_param = 100},
  [101] = {interact_id = 101, interact_param = 101},
  [102] = {interact_id = 102, interact_param = 102},
  [103] = {interact_id = 103, interact_param = 103},
  [104] = {interact_id = 104, interact_param = 104},
  [105] = {interact_id = 105, interact_param = 105},
  [106] = {interact_id = 106, interact_param = 106},
  [107] = {interact_id = 107, interact_param = 107},
  [108] = {interact_id = 108, interact_param = 108},
  [109] = {interact_id = 109, interact_param = 109}
}
local __default_values = {
  interact_id = 1,
  interact_param = 0,
  interact_type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_interact_entity) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_interact_entity, {__index = __rawdata})
return delivery_interact_entity
