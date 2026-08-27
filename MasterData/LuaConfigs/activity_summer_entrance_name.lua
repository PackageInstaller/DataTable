local activity_summer_entrance_name = {
  {
    name = 522046,
    name_en = "Battlefield Entry"
  },
  {
    id = 2,
    name = 205621,
    name_en = "Variable Deduction",
    name_func = 412892
  },
  {
    id = 3,
    name = 81479,
    name_en = "Ribbon Theory",
    name_func = 211381
  },
  {
    id = 4,
    name = 508954,
    name_func = 277829
  },
  {
    id = 5,
    name_en = "Survival Strategy",
    name_func = 94783
  },
  {
    id = 6,
    name = 349607,
    name_en = "Doll Rescue",
    name_func = 478243
  },
  {
    id = 7,
    name = 494869,
    name_en = "Combustion Cycle",
    name_func = 44199
  }
}
local __default_values = {
  id = 1,
  name = 189171,
  name_en = "Accumulative Array",
  name_func = "",
  unlock_time = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_summer_entrance_name) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_summer_entrance_name, {__index = __rawdata})
return activity_summer_entrance_name
