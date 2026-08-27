local milestone_mile_profile = {
  {location = 0, text = 37075},
  {
    id = 2,
    location = 0,
    text = 217471
  },
  {
    id = 3,
    location = 0,
    text = 524061
  },
  {
    id = 4,
    location = 0,
    text = 421148
  },
  {id = 5},
  {id = 6, text = 358778},
  {id = 7, text = 292114},
  {id = 8, text = 504792},
  {id = 9, text = 500358}
}
local __default_values = {
  id = 1,
  location = 1,
  text = 173291
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(milestone_mile_profile) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(milestone_mile_profile, {__index = __rawdata})
return milestone_mile_profile
