local UINSkyPosInput = class("UINSkyPosInput", UIBaseNode)
local base = UIBaseNode

function UINSkyPosInput:ctor(uiSkyRoot)
  self.uiSkyRoot = uiSkyRoot
end

function UINSkyPosInput:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_S, self, self._OnClickLatitude, false)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_N, self, self._OnClickLatitude, true)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_W, self, self._OnClickLongitude, false)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_E, self, self._OnClickLongitude, true)
  UIUtil.AddValueChangedListener(self.ui.inputField_SN, self, self._OnValueChange_Latitude)
  UIUtil.AddValueChangedListener(self.ui.inputField_WE, self, self._OnValueChange_Longitude)
end

function UINSkyPosInput:InitSkyPosInput(latitude, longitude)
  self:Show()
  UIUtil.HideTopStatus()
  self.isN = 0 <= latitude
  self.isE = 0 <= longitude
  self.latitude = math.abs(latitude)
  self.longitude = math.abs(longitude)
  self.ui.inputField_SN.text = tostring(self.latitude)
  self.ui.inputField_WE.text = tostring(self.longitude)
  self:_UpdSNTog()
  self:_UpdWETog()
end

function UINSkyPosInput:_UpdSNTog()
  local pos = self.ui.img_SelectSN.anchoredPosition
  pos.x = math.abs(pos.x) * (self.isN and 1 or -1)
  self.ui.img_SelectSN.anchoredPosition = pos
  self.ui.tex_N.color = self.isN and self.ui.selectTogColor or Color.white
  self.ui.tex_S.color = self.isN and Color.white or self.ui.selectTogColor
end

function UINSkyPosInput:_UpdWETog()
  local pos = self.ui.img_SelectWE.anchoredPosition
  pos.x = math.abs(pos.x) * (self.isE and 1 or -1)
  self.ui.img_SelectWE.anchoredPosition = pos
  self.ui.tex_E.color = self.isE and self.ui.selectTogColor or Color.white
  self.ui.tex_W.color = self.isE and Color.white or self.ui.selectTogColor
end

function UINSkyPosInput:_OnValueChange_Latitude(value)
  local latitudeValue = tonumber(value)
  if latitudeValue == nil then
    return
  end
  local latitude = math.clamp(latitudeValue, 0, 90)
  if latitude ~= latitudeValue then
    self.ui.inputField_SN.text = tostring(latitude)
  end
  self.latitude = latitude
end

function UINSkyPosInput:_OnValueChange_Longitude(value)
  local longitudeValue = tonumber(value)
  if longitudeValue == nil then
    return longitudeValue
  end
  local longitude = math.clamp(longitudeValue, 0, 180)
  if longitude ~= longitudeValue then
    self.ui.inputField_WE.text = tostring(longitude)
  end
  self.longitude = longitude
end

function UINSkyPosInput:_OnClickLatitude(isN)
  if self.isN == isN then
    return
  end
  self.isN = isN
  self:_UpdSNTog()
end

function UINSkyPosInput:_OnClickLongitude(isE)
  if self.isE == isE then
    return
  end
  self.isE = isE
  self:_UpdWETog()
end

function UINSkyPosInput:_OnClickConfirm()
  self.uiSkyRoot:UpdSkySystemLocation(self.latitude * (self.isN and 1 or -1), self.longitude * (self.isE and 1 or -1), true)
  self:_OnClickClose()
end

function UINSkyPosInput:_OnClickClose()
  self:Hide()
  UIUtil.ReShowTopStatus()
end

function UINSkyPosInput:OnDelete()
  base.OnDelete(self)
end

return UINSkyPosInput
