local lottery_selection = {
  [7] = {}
}
local __default_values = {
  id = 7,
  item_rewardIds = {
    2018,
    2010,
    2016,
    2008,
    2028,
    2025,
    2026,
    2039,
    2042,
    2045,
    2054,
    2037
  },
  item_rewardNums = {
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(lottery_selection) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(lottery_selection, {__index = __rawdata})
return lottery_selection
