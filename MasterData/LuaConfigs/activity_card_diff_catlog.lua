local activity_card_diff_catlog = {
  {catalog_des = 16334},
  {catalog_des = 43523, catalog_id = 2},
  {catalog_des = 485659, catalog_id = 3},
  {catalog_des = 444583, catalog_id = 4},
  {catalog_des = 413682, catalog_id = 5},
  {catalog_des = 199972, catalog_id = 6},
  {catalog_des = 286289, catalog_id = 7},
  {catalog_des = 393332, catalog_id = 8},
  {catalog_des = 362431, catalog_id = 9},
  {catalog_des = 257233, catalog_id = 10},
  {catalog_des = 205982, catalog_id = 11},
  {catalog_des = 47688, catalog_id = 12},
  [100] = {catalog_des = 458556, catalog_id = 100},
  [101] = {catalog_des = 521346, catalog_id = 101},
  [110] = {catalog_des = 173520, catalog_id = 110},
  [111] = {catalog_des = 222604, catalog_id = 111},
  [200] = {catalog_id = 200}
}
local __default_values = {catalog_des = 13672, catalog_id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_card_diff_catlog) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_card_diff_catlog, {__index = __rawdata})
return activity_card_diff_catlog
