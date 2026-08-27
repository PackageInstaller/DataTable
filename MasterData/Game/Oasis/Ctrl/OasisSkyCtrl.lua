local base = require("Game.Formation.Ctrl.FormationCtrlBase")
local OasisSkyCtrl = class("OasisCtrlBase", base)
local cs_SkyController = CS.SkyController

function OasisSkyCtrl:ctor(oasisCtrl)
  self.oasisCtrl = oasisCtrl
  table.insert(self.oasisCtrl.ctrls, self)
end

function OasisSkyCtrl:InitOasisSkyCtrl()
  local unlockSkySetting = PlayerDataCenter.AllBuildingData.built[eBuildingId.SkyBuilding] ~= nil
  local systemData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  self._systemData = systemData
  local presetId = self:GetSkyPresetId()
  local latitude, longitude, month, hour
  month = self:GetSavedSkyMonth()
  hour = self:GetSavedSkyHour()
  if presetId == 0 or not unlockSkySetting then
    latitude, longitude = self:GetDefaultSkySetting()
  elseif presetId == -1 then
    latitude, longitude = systemData:GetOasisSkyLocation()
  else
    local presetCfg = ConfigData.oasis_weather_preset[presetId]
    if presetCfg == nil then
      error("Cant get ConfigData.oasis_weather_preset, presetId = " .. tostring(presetId))
      latitude, longitude = self:GetDefaultSkySetting()
    else
      latitude = presetCfg.latitude
      longitude = presetCfg.longitude
    end
  end
  cs_SkyController.Instance.Longitude = longitude
  cs_SkyController.Instance.Latitude = latitude
  cs_SkyController.Instance.Month = month
  cs_SkyController.Instance.Timeline = hour
end

function OasisSkyCtrl:ShowOasisSkySetting()
  UIManager:ShowWindowAsync(UIWindowTypeID.USkySystem, function(window)
    if window == nil then
      return
    end
    window:InitOasisSkyUI(self)
  end)
end

function OasisSkyCtrl:GetDefaultSkySetting()
  local latitude, longitude = 40, 116
  local month = tonumber(os.date("%m"))
  local hour = tonumber(os.date("%H"))
  return latitude, longitude, month, hour
end

function OasisSkyCtrl:GetSkyPresetId()
  local presetId = self._systemData:GetOasisSkyPreset()
  return presetId
end

function OasisSkyCtrl:SetSkyPresetIdSave(presetId)
  self._systemData:SetOasisSkyPreset(presetId)
end

function OasisSkyCtrl:GetSavedSkyHour()
  local hourOffset = PlayerDataCenter.cacheSaveData:GetOasisSkyHourOffset()
  local hour = tonumber(os.date("%H"))
  hour = (hour + hourOffset) % 24
  return hour
end

function OasisSkyCtrl:SetSkyHour(hour)
  cs_SkyController.Instance:SetHourTween(hour)
  local curHour = tonumber(os.date("%H"))
  local hourOffset = hour - curHour
  PlayerDataCenter.cacheSaveData:SetOasisSkyHourOffset(hourOffset)
end

function OasisSkyCtrl:GetSavedSkyMonth()
  local monthOffet = PlayerDataCenter.cacheSaveData:GetOasisSkyMonthOffset()
  local month = self:GetCurSkyMonth()
  month = (month + monthOffet) % 12
  if month == 0 then
    month = 12
  end
  return month
end

function OasisSkyCtrl:SetSkyMonth(month)
  cs_SkyController.Instance.Month = month
  local curMonth = self:GetCurSkyMonth()
  local monthOffset = month - curMonth
  PlayerDataCenter.cacheSaveData:SetOasisSkyMonthOffset(monthOffset)
end

function OasisSkyCtrl:GetCurSkyMonth()
  local month = tonumber(os.date("%m"))
  return month
end

function OasisSkyCtrl:SetSkyLocation(latitude, longitude, hour)
  cs_SkyController.Instance.Longitude = longitude
  cs_SkyController.Instance.Latitude = latitude
  cs_SkyController.Instance:SetHourTween(hour)
  self._systemData:SetOasisSkyLocation(latitude, longitude)
end

function OasisSkyCtrl:GenRandomOasisSkySetting(curTime)
  local longitude = math.random(-180, 180)
  local latitude = math.random(-90, 90)
  local month = math.random(1, 12)
  local time = math.random(curTime + 6, curTime + 12)
  time = time % 24
  return latitude, longitude, month, time
end

function OasisSkyCtrl:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.USkySystem)
  base.OnDelete(self)
end

return OasisSkyCtrl
