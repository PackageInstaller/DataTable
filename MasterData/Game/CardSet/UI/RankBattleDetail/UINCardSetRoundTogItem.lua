local base = UIBaseNode
local UINCardSetRoundTogItem = class("UINCardSetRoundTogItem", base)

function UINCardSetRoundTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.tog_item, self, self.__OnClick)
end

function UINCardSetRoundTogItem:InitCardRankTogItem(index, selectCallback, clickCallback)
  self.index = index
  self.selectCallback = selectCallback
  self.clickCallback = clickCallback
  self.ui.textInfo:SetIndex(index - 1)
end

function UINCardSetRoundTogItem:SetCardRankTogItemIsSelected(bool)
  if bool then
    self.ui.img_tog_item.color = self.ui.color_selected
    self.ui.text_text.color = Color.white
    if self.selectCallback ~= nil then
      self.selectCallback()
    end
  else
    self.ui.img_tog_item.color = self.ui.color_notSelected
    self.ui.text_text.color = self.ui.text_color_not_select
  end
end

function UINCardSetRoundTogItem:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback()
  end
end

function UINCardSetRoundTogItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetRoundTogItem
