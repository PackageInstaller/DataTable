local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINActSum22TechInfo = class("UINActSum22TechInfo", base)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UINActSum22TechInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
end

function UINActSum22TechInfo:SetActSum22TechInfoHideFnc(hideFunc)
  self._hideFunc = hideFunc
end

function UINActSum22TechInfo:InitActSum22TechInfo(techData, targetTransform)
  self:FloatTo(targetTransform, HAType.autoCenter, VAType.downAuto)
  local curLv = techData:GetCurLevel()
  curLv = curLv == 0 and 1 or curLv
  if techData:IsActTechLevelLoop() then
    self.ui.tex_lv.text.text = tostring(curLv)
  else
    local maxLv = techData:GetMaxLevel()
    self.ui.tex_lv:SetIndex(0, tostring(curLv), tostring(maxLv))
  end
  self.ui.tex_BuffName.text = techData:GetAWTechName()
  self.ui.tex_Des.text = techData:GetTechDescription(nil, eLogicDesType.Warchess)
end

function UINActSum22TechInfo:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UINActSum22TechInfo:OnShow()
  base.OnShow(self)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
end

function UINActSum22TechInfo:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  if self._hideFunc ~= nil then
    self._hideFunc()
  end
  base.OnHide(self)
end

function UINActSum22TechInfo:OnDelete()
  base.OnDelete(self)
end

return UINActSum22TechInfo
