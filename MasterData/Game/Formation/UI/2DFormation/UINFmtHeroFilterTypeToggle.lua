local UINFmtHeroFilterTypeToggle = class("UINFmtHeroFilterTypeToggle", UIBaseNode)
local base = UIBaseNode

function UINFmtHeroFilterTypeToggle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.toggle, self, self.__OnToggle)
  self.defalutBgColor = self.ui.img_toggle.color
  self.unSelectBgColor = Color.New(0, 0, 0, 0)
end

function UINFmtHeroFilterTypeToggle:InitFilterTypeToggle(index, callback)
  self._callback = callback
  self.ui.tex_Text:SetIndex(index)
end

function UINFmtHeroFilterTypeToggle:OnToggleHeroFilterType(flag)
  if self.ui.toggle.isOn == flag then
    self:__OnToggle(flag)
  else
    self.ui.toggle.isOn = flag
  end
end

function UINFmtHeroFilterTypeToggle:__OnToggle(flag)
  if flag then
    self.ui.img_toggle.color = self.defalutBgColor
    self.ui.tex_Text.text.color = Color.black
  else
    self.ui.img_toggle.color = self.unSelectBgColor
    self.ui.tex_Text.text.color = Color.white
  end
  if flag then
    self._callback()
  end
end

return UINFmtHeroFilterTypeToggle
