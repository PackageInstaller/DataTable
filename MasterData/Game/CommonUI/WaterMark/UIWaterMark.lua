local UIWaterMark = class("UIWaterMark", UIBaseWindow)
local base = UIBaseWindow

function UIWaterMark:OnInit()
  self.__permanent = true
  self.__OnScreenSizeChanged = BindCallback(self, self._OnScreenSizeChanged)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
end

function UIWaterMark:SetWaterMarkUID(uid)
  local uidStr = tostring(uid)
  local contentStr = uidStr .. "  <color=#808080>" .. uidStr .. "</color>  "
  for i = 1, 8 do
    contentStr = contentStr .. contentStr
  end
  self.ui.tex_WaterMark.text = contentStr
  self.ui.tex_WaterMark.transform.eulerAngles = Vector3.New(0, 0, -10)
  self._uidAngle = 10
  self:_UpdUIDMarkSize()
end

function UIWaterMark:_UpdUIDMarkSize()
  local x = UIManager.BackgroundStretchSize.x
  local y = UIManager.BackgroundStretchSize.y
  local rad = math.rad(self._uidAngle)
  local cosRad = math.cos(rad)
  local sinRad = math.sin(rad)
  local width = y * sinRad + x * cosRad
  local height = y * cosRad + x * sinRad
  self.ui.tex_WaterMark.transform.sizeDelta = Vector2.New(width, height)
end

function UIWaterMark:_OnScreenSizeChanged()
  self:_UpdUIDMarkSize()
end

function UIWaterMark:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  base.OnDelete(self)
end

return UIWaterMark
