local ath_area = {
  {},
  {
    id = 2,
    name2 = 63594,
    name3 = "SURVIVABILITY"
  },
  {
    id = 3,
    name2 = 483221,
    name3 = "SPECIFICITY"
  },
  {
    id = 4,
    name2 = 76110,
    name3 = "ALL AREA"
  }
}
local __default_values = {
  id = 1,
  name2 = 43453,
  name3 = "AGGRESSIVITY"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(ath_area) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_area, {__index = __rawdata})
return ath_area
