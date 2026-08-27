local UINNavSpeciaOasisCollectRewardItem = class("UINNavSpeciaOasisCollectRewardItem", UIBaseNode)
local base = UIBaseNode

function UINNavSpeciaOasisCollectRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINNavSpeciaOasisCollectRewardItem:SetNSOCRItemImage(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("itemCfg is nill id:" .. tostring(itemId))
    return
  end
  self.ui.img_SmallIcon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

function UINNavSpeciaOasisCollectRewardItem:RefreshNSOCRItemRate(rate)
  self.ui.img_Rate.fillAmount = rate or 0
end

function UINNavSpeciaOasisCollectRewardItem:GetFillAmountImage()
  return self.ui.img_Rate
end

function UINNavSpeciaOasisCollectRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINNavSpeciaOasisCollectRewardItem
