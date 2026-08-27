local UINAvgChooseItem = class("UINAvgChooseItem", UIBaseNode)
local base = UIBaseNode

function UINAvgChooseItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.OnClickRootBtn)
end

function UINAvgChooseItem:InitAvgChooseItem(index, content, clickEvent, couldNotSelect)
  self.index = index
  self.clickEvent = clickEvent
  self.ui.rootBtn.interactable = not couldNotSelect
  self.ui.tex_Tile:SetIndex(0, tostring(index))
  self.ui.tex_ChooseText.text = content
end

function UINAvgChooseItem:OnClickRootBtn()
  if self.clickEvent ~= nil then
    self.clickEvent(self.index)
  end
end

function UINAvgChooseItem:OnDelete()
  base.OnDelete(self)
end

return UINAvgChooseItem
