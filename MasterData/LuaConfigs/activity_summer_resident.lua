local activity_summer_resident = {
  [140021] = {}
}
local __default_values = {
  id = 140021,
  is_hard_open = false,
  scale_zoom = {
    1.5,
    0.6,
    1.0
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_summer_resident) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_summer_resident, {__index = __rawdata})
return activity_summer_resident
