local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINFormationBondFloat = class("UINFormationBondFloat", base)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UINFormationBondFloat:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
end

function UINFormationBondFloat:InitBondFloat(transform, name, des)
  self:FloatTo(transform, HAType.right, VAType.down)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(des)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(name)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
end

function UINFormationBondFloat:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UINFormationBondFloat:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  base.OnHide(self)
end

function UINFormationBondFloat:OnDelete()
  base.OnDelete(self)
end

return UINFormationBondFloat
