local UINActivityCollectFortuneGiftLotteryToggleItem = class("UINActivityCollectFortuneGiftLotteryToggleItem", UIBaseNode)
local base = UIBaseNode

function UINActivityCollectFortuneGiftLotteryToggleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActivityCollectFortuneGiftLotteryToggleItem:InitCollectFortuneToggleItem(text)
  if not string.IsNullOrEmpty(text) then
    self.ui.Text.text = text
  end
  self.ui.Toggle.isOn = false
end

function UINActivityCollectFortuneGiftLotteryToggleItem:SetToggleItemIsSelected(isOn)
  self.ui.Toggle.isOn = isOn
end

function UINActivityCollectFortuneGiftLotteryToggleItem:OnToggleItemValueChanged(isOn, color, textColor)
  self.ui.Image.color = color
  self.ui.Text.color = textColor
end

function UINActivityCollectFortuneGiftLotteryToggleItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityCollectFortuneGiftLotteryToggleItem
