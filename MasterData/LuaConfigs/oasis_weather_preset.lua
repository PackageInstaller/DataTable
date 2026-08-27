local oasis_weather_preset = {
  {
    latitude = 40,
    longitude = 116,
    preset_name = 245310
  },
  {
    id = 2,
    latitude = 30,
    longitude = 121,
    preset_name = 330134
  },
  {
    id = 3,
    latitude = 36,
    longitude = 140,
    preset_name = 388254,
    utc = 9
  },
  {
    id = 4,
    latitude = 37,
    longitude = 127,
    utc = 9
  },
  {
    id = 5,
    latitude = 39,
    longitude = -77,
    preset_name = 88438,
    utc = -4
  },
  {
    id = 6,
    latitude = 51,
    preset_name = 370769,
    utc = 1
  },
  {
    id = 7,
    latitude = 55,
    longitude = 37,
    preset_name = 46475,
    utc = 3
  },
  {
    id = 8,
    latitude = 52,
    longitude = 13,
    preset_name = 54313,
    utc = 2
  },
  {
    day_time = 12,
    id = 9,
    month = 9,
    preset_name = 335762,
    utc = 0
  }
}
local __default_values = {
  day_time = 0,
  id = 1,
  latitude = -90,
  longitude = 0,
  month = 0,
  preset_name = 150484,
  utc = 8
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(oasis_weather_preset) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(oasis_weather_preset, {__index = __rawdata})
return oasis_weather_preset
