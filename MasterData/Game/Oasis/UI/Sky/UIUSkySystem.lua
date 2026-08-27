local UIUSkySystem = class("UIUSkySystem", UIBaseWindow)
local base = UIBaseWindow
local UINSkyPosInput = require("Game.Oasis.UI.Sky.UINSkyPosInput")
local UINSkyPreset = require("Game.Oasis.UI.Sky.Preset.UINSkyPreset")
local UINSkyMap = require("Game.Oasis.UI.Sky.UINSkyMap")
local cs_SkyController = CS.SkyController
local CS_EventTriggerListener = CS.EventTriggerListener

function UIUSkySystem:OnInit()
  UIUtil.AddValueChangedListener(self.ui.slider_Month, self, self._OnValueChange_Month)
  UIUtil.AddValueChangedListener(self.ui.slider_Hour, self, self._OnValueChange_Hour)
  UIUtil.AddButtonListener(self.ui.btn_ChangePos, self, self._OnClickChangePos)
  UIUtil.AddButtonListener(self.ui.btn_Random, self, self._OnClickRandom)
  UIUtil.AddButtonListener(self.ui.btn_DefList, self, self._OnClickPreset)
  self._OnHourChangeFunc = BindCallback(self, self._OnHourChange)
  self._OnMonthChangeFunc = BindCallback(self, self._OnMonthChange)
  CS_EventTriggerListener.Get(self.ui.slider_Month.gameObject):onDown("+", BindCallback(self, self._OnPointerDownSliderMonth))
  CS_EventTriggerListener.Get(self.ui.slider_Month.gameObject):onUp("+", BindCallback(self, self._OnPointerUpSliderMonth))
  CS_EventTriggerListener.Get(self.ui.slider_Hour.gameObject):onDown("+", BindCallback(self, self._OnPointerDownSliderHour))
  CS_EventTriggerListener.Get(self.ui.slider_Hour.gameObject):onUp("+", BindCallback(self, self._OnPointerUpSliderHour))
  self.skyMapNode = UINSkyMap.New(self)
  self.skyMapNode:Init(self.ui.mapNode)
end

function UIUSkySystem:InitOasisSkyUI(oasisSkyCtrl)
  self.oasisSkyCtrl = oasisSkyCtrl
  UIUtil.SetTopStatus(self, self._ExitSkySystem)
  self:_UpdHour(math.floor(cs_SkyController.Instance.Timeline))
  self:_UpdMonth(cs_SkyController.Instance.Month)
  local latitude = cs_SkyController.Instance.Latitude
  local longitude = cs_SkyController.Instance.Longitude
  self:UpdSkySystemLocation(latitude, longitude, false, true)
  self.skyMapNode:InitSkyMap(latitude, longitude)
  self:_ShowSkySideTween(true)
end

function UIUSkySystem:OnShow()
  base.OnShow(self)
  cs_SkyController.Instance.OnHourChange = self._OnHourChangeFunc
  cs_SkyController.Instance.OnMonthChange = self._OnMonthChangeFunc
end

function UIUSkySystem:OnHide()
  cs_SkyController.Instance.OnHourChange = nil
  cs_SkyController.Instance.OnMonthChange = nil
  base.OnHide(self)
end

function UIUSkySystem:_OnHourChange(hour)
  self:_UpdHour(hour)
end

function UIUSkySystem:_OnMonthChange(month)
  self:_UpdMonth(month)
end

function UIUSkySystem:_ShowSkySideTween(show)
  if self.sideIsShow == show then
    return
  end
  self.sideIsShow = show
  self.ui.root_CanvasGroup.blocksRaycasts = show
  if show then
    self.ui.sideTween:DORestart()
  else
    self.ui.sideTween:DOPlayBackwards()
  end
end

function UIUSkySystem:UpdSkySystemLocation(latitude, longitude, withSet, notSetMap)
  if self.longitude == longitude and self.latitude == latitude then
    return
  end
  self.longitude = longitude
  self.latitude = latitude
  local lontSign = ""
  if 0 < longitude then
    lontSign = "E"
  elseif longitude < 0 then
    lontSign = "W"
  end
  local latSign = ""
  if 0 < latitude then
    latSign = "N"
  elseif latitude < 0 then
    latSign = "S"
  end
  self.ui.tex_Pos:SetIndex(0, tostring(FormatNum(math.abs(latitude))), latSign, tostring(FormatNum(math.abs(longitude))), lontSign)
  if not notSetMap then
    self.skyMapNode:SetSkyMapLocation(latitude, longitude)
  end
  if withSet then
    self.oasisSkyCtrl:SetSkyLocation(latitude, longitude, self.hour)
    self.oasisSkyCtrl:SetSkyPresetIdSave(-1)
  end
end

function UIUSkySystem:_UpdHour(hour, withSet)
  hour = FormatNum(hour)
  if self.hour == hour then
    return
  end
  self.hour = hour
  self.ui.tex_Hour.text = tostring(hour)
  if self.ui.slider_Hour.value ~= hour then
    self.ui.slider_Hour.value = hour
  end
  if withSet then
    self.oasisSkyCtrl:SetSkyHour(hour)
  end
end

function UIUSkySystem:_UpdMonth(month, withSet)
  month = FormatNum(month)
  if self.month == month then
    return
  end
  self.month = month
  self.ui.tex_Month.text = tostring(month)
  if self.ui.slider_Month.value ~= month then
    self.ui.slider_Month.value = month
  end
  if withSet then
    self.oasisSkyCtrl:SetSkyMonth(month)
  end
end

function UIUSkySystem:_OnValueChange_Month(value)
  if self.month == value then
    return
  end
  self:_UpdMonth(value, true)
end

function UIUSkySystem:_OnValueChange_Hour(value)
  if self.hour == value then
    return
  end
  self:_UpdHour(value, true)
end

function UIUSkySystem:_OnPointerDownSliderHour()
  self.ui.normal:SetActive(false)
  self.ui.month:SetActive(false)
end

function UIUSkySystem:_OnPointerUpSliderHour()
  self.ui.normal:SetActive(true)
  self.ui.month:SetActive(true)
end

function UIUSkySystem:_OnPointerDownSliderMonth()
  self.ui.normal:SetActive(false)
  self.ui.hour:SetActive(false)
end

function UIUSkySystem:_OnPointerUpSliderMonth()
  self.ui.normal:SetActive(true)
  self.ui.hour:SetActive(true)
end

function UIUSkySystem:_OnClickChangePos()
  if self.posInputNode == nil then
    self.posInputNode = UINSkyPosInput.New(self)
    self.posInputNode:Init(self.ui.posInputNode)
  end
  self.posInputNode:InitSkyPosInput(self.latitude, self.longitude)
end

function UIUSkySystem:_OnClickRandom()
  local longitude
  local latitude, longitude, month, hour = self.oasisSkyCtrl:GenRandomOasisSkySetting(self.hour)
  self:UpdSkySystemLocation(latitude, longitude, true)
  self:_UpdMonth(month, true)
  self:_UpdHour(hour, true)
end

function UIUSkySystem:_OnClickPreset()
  if self.presetNode == nil then
    self.presetNode = UINSkyPreset.New(self)
    self.presetNode:Init(self.ui.presetListNode)
  end
  self.presetNode:InitSkyPreset()
end

function UIUSkySystem:SetUISkyPreset(presetId)
  local latitude, longitude, month, hour
  if presetId == 0 then
    latitude, longitude, month, hour = self.oasisSkyCtrl:GetDefaultSkySetting()
  else
    local presetCfg = ConfigData.oasis_weather_preset[presetId]
    latitude = presetCfg.latitude
    longitude = presetCfg.longitude
    if presetCfg.day_time == 0 then
      hour = tonumber(os.date("!%H"))
      hour = (hour + presetCfg.utc) % 24
    else
      hour = presetCfg.day_time % 24
    end
    if presetCfg.month == 0 then
      month = self.oasisSkyCtrl:GetCurSkyMonth()
    else
      month = presetCfg.month
    end
  end
  self:_UpdHour(hour, true)
  self:_UpdMonth(month)
  self.oasisSkyCtrl:SetSkyMonth(month)
  self:UpdSkySystemLocation(latitude, longitude, true)
  self.oasisSkyCtrl:SetSkyPresetIdSave(presetId)
end

function UIUSkySystem:_ExitSkySystem()
  self:_ShowSkySideTween(false)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.SystemData)
  self.oasisSkyCtrl.oasisCtrl:ExitOasisSkyMode()
end

function UIUSkySystem:OnDelete()
  if self.posInputNode ~= nil then
    self.posInputNode:OnDelete()
  end
  if self.presetNode ~= nil then
    self.presetNode:OnDelete()
  end
  self.skyMapNode:OnDelete()
  base.OnDelete(self)
end

return UIUSkySystem
