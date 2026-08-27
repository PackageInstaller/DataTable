local UINRewardItem = class("UINRewardItem", UIBaseNode)

function UINRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRewardItem:InitRewardItem(resloader, itemData, overCount)
  local count = overCount or itemData.count
  self.ui.tex_Count.text = tostring(count)
  self.ui.img_Pic.sprite = CRH:GetSprite(itemData.icon)
  self.ui.tex_Name.text = itemData.name
end

return UINRewardItem
