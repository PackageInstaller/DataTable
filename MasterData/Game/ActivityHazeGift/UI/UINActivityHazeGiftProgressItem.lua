local UINActivityHazeGiftProgressItem = class("UINActivityHazeGiftProgressItem", UIBaseNode)
local base = UIBaseNode

function UINActivityHazeGiftProgressItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActivityHazeGiftProgressItem:InitHazeGiftProgressItem(score)
  self.ui.text_num.text = tostring(score)
end

function UINActivityHazeGiftProgressItem:HideProgressItemLine()
  self.ui.slider.gameObject:SetActive(false)
end

function UINActivityHazeGiftProgressItem:RefreshProgressItem(value)
  self.ui.go_reachDot:SetActive(0 <= value)
  self.ui.slider.gameObject:SetActive(true)
  self.ui.slider.value = value
end

function UINActivityHazeGiftProgressItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityHazeGiftProgressItem
