local exploration_treasure = {
  {},
  [500] = {
    id = 500,
    logic = 2,
    treasure_id = 2001
  }
}
local __default_values = {
  id = 1,
  logic = 1,
  treasure_id = 1001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_treasure) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_treasure, {__index = __rawdata})
return exploration_treasure
