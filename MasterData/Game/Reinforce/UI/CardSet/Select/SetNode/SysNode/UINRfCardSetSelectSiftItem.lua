local base = UIBaseNode
local UINRfCardSetSelectSiftItem = class("UINRfCardSetSelectSiftItem", base)

function UINRfCardSetSelectSiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.OnClickSiftItem)
  self.isOpen = false
end

function UINRfCardSetSelectSiftItem:InitRfCardSetSelectSiftItem(index, callback)
  self.index = index
  self.callback = callback
  self:RefreshItemShow()
end

function UINRfCardSetSelectSiftItem:RefreshItemShow()
  local cfg = ConfigData.reinforce_card_label[self.index]
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.name)
end

function UINRfCardSetSelectSiftItem:SetSiftItemOpen(bool)
  self.isOpen = bool
  self.ui.tex_Name.color = self.isOpen and self.ui.col_texBlack or self.ui.col_white
  self.ui.img_Bg.color = self.isOpen and self.ui.col_white or self.ui.col_imgBlack
end

function UINRfCardSetSelectSiftItem:OnClickSiftItem()
  if self.callback then
    self.callback(self.index, self)
  end
end

function UINRfCardSetSelectSiftItem:OnDelete()
end

return UINRfCardSetSelectSiftItem
