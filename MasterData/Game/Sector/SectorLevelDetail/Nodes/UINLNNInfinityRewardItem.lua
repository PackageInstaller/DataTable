local UINLNNInfinityRewardItem = class("UINLNNInfinityRewardItem", UIBaseNode)
local base = UIBaseNode

function UINLNNInfinityRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLNNInfinityRewardItem:InitReardItem(itemId, Num)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("can't read itemCfg id=" .. tostring(itemId))
    self:Hide()
    return
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
  self.ui.tex_Count.text = tostring(Num)
end

function UINLNNInfinityRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINLNNInfinityRewardItem
