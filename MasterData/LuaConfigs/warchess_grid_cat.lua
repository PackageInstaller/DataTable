local warchess_grid_cat = {
  {},
  {id = 2},
  {id = 3},
  {id = 4},
  {id = 5},
  {id = 6},
  [8] = {
    id = 8,
    rotate = true,
    rotate_index = 2
  },
  [9] = {id = 9},
  [10] = {id = 10}
}
local __default_values = {
  id = 1,
  rotate = false,
  rotate_index = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_grid_cat) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_grid_cat, {__index = __rawdata})
return warchess_grid_cat
