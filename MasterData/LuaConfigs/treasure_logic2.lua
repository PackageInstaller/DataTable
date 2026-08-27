local treasure_logic2 = {
  [2001] = {}
}
local __default_values = {
  costId = 1,
  costNums = {
    10,
    10,
    20,
    20
  },
  id = 2001,
  maxRefreshTime = 3,
  times = {
    0,
    1,
    2,
    3
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(treasure_logic2) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(treasure_logic2, {__index = __rawdata})
return treasure_logic2
