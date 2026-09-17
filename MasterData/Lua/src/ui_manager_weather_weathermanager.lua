local this = class("weatherManager")
local weatherType = {
  [1] = "Global",
  [2] = "Sun",
  [3] = "Rian"
}
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldPointTpl = L_GameTpl:getWorldBorthposTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()
local _areaTpl = L_GameTpl:getAreaTpl()

function this:ctor()
  self.weatherList = {}
  self.lastWeather = nil
end

function this:refreshWeatherList()
  self.weatherList = {}
  local weatherList = C_RealWeather.GetWeatherList()
  if weatherList then
    for i = 0, weatherList.Count - 1 do
      local name = weatherList[i]
      table.insert(self.weatherList, {weatherName = name, weatherIndex = i})
    end
  end
end

function this:refreshWeatherByIndex(weatherIndex)
  if self.weatherList[weatherIndex + 1] then
    self.lastWeather = self:getCurWeather()
    C_RealWeather.SetWeather(weatherIndex)
  end
end

function this:refreshWeatherByName(weatherName)
  for i, v in pairs(self.weatherList) do
    if v.weatherName == weatherName then
      self.lastWeather = self:getCurWeather()
      C_RealWeather.SetWeather(weatherName)
      break
    end
  end
end

function this:getCurWeather()
  return C_RealWeather.GetCurWeatherName()
end

function this:getPreviousWeather()
  if self.lastWeather then
    return self.lastWeather
  else
    return C_RealWeather.GetCurWeatherName()
  end
end

return this
