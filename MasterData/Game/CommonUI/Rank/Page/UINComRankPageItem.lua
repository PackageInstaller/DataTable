local base = UIBaseNode
local UINComRankPageItem = class("UINComRankPageItem", base)

function UINComRankPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Page, self, self._OnClickTog)
end

function UINComRankPageItem:InitComRankPageItem(comRankPageType, clickFunc)
  self._comRankPageType = comRankPageType
  self._clickFunc = clickFunc
  self.ui.tex_PageName:SetIndex(comRankPageType)
  self:_OnClickTog(false)
end

function UINComRankPageItem:SetComRankPageItemIsOn()
  self.ui.tog_Page.isOn = true
end

function UINComRankPageItem:_OnClickTog(isOn)
  self.ui.tex_PageName.text.color = isOn and self.ui.col_NameSel or self.ui.col_NameUnSel
  self.ui.img_PageBG:SetIndex(isOn and 0 or 1)
  if self._clickFunc ~= nil and isOn then
    self._clickFunc(self._comRankPageType)
  end
end

function UINComRankPageItem:OnDelete()
  base.OnDelete(self)
end

return UINComRankPageItem
