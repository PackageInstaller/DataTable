local oasis_weather = {
  {
    amb_audio_id = 0,
    audio_aisac_control = "",
    weight = 200
  },
  {
    id = 2,
    rain_intensity = 30,
    weight = 60,
    wetting_intensity = 30,
    wind_intensity = 30
  },
  {
    audio_aisac_value = 0.5,
    id = 3,
    rain_intensity = 60,
    weight = 30,
    wetting_intensity = 60,
    wind_intensity = 60
  },
  {
    audio_aisac_value = 1,
    id = 4,
    rain_intensity = 90,
    wetting_intensity = 90,
    wind_intensity = 90
  }
}
local __default_values = {
  accumulated_snow_intensity = 0,
  amb_audio_id = 2001,
  audio_aisac_control = "AisacControl_RainType",
  audio_aisac_value = 0,
  id = 1,
  lightning_intensity = 0,
  rain_intensity = 0,
  snow_intensity = 0,
  trans_duration = 3,
  weather_duration = 300,
  weight = 10,
  wetting_intensity = 0,
  wind_intensity = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(oasis_weather) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(oasis_weather, {__index = __rawdata})
return oasis_weather
