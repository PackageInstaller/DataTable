local base = UIBaseNode
local UICarnivalMemoryOrderConsumeInfoItem = class("UICarnivalMemoryOrderConsumeInfoItem", base)

function UICarnivalMemoryOrderConsumeInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.CostNumColors = {}
end

function UICarnivalMemoryOrderConsumeInfoItem:InitCarnivalMemoryOrderConsumeInfoItem(consumeItemId, consumeItemHoldingCount, consumeItemNeedCount)
  UIUtil.LuaUIBindingTable(self.ui.tex_CostNum.transform, self.CostNumColors)
  self:Refresh(consumeItemId, consumeItemHoldingCount, consumeItemNeedCount)
end

function UICarnivalMemoryOrderConsumeInfoItem:Refresh(itemId, currentNum, needNum)
  local itemCfg = ConfigData.item[itemId]
  self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
  self.ui.tex_CostNum.text = string.format("%s/%s", tostring(currentNum), tostring(needNum))
  self.ui.tex_CostNum.color = needNum <= currentNum and self.CostNumColors.CompletedColor or self.CostNumColors.notCompletedColor
end

function UICarnivalMemoryOrderConsumeInfoItem:OnDelete()
  self.CostNumColors = nil
end

return UICarnivalMemoryOrderConsumeInfoItem
