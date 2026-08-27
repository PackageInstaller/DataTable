local base = UIBaseNode
local UIDeliverySimulatorOrderGoodsItem = class("UIDeliverySimulatorOrderGoodsItem", base)

function UIDeliverySimulatorOrderGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIDeliverySimulatorOrderGoodsItem:InitDeliverySimulatorOrderGoodsItem(order, index)
  local goodsId = order.cfg.good_id_list[index]
  self:UpdateGoodsIcon(order:GetGoodsSprite(goodsId))
  self:UpdateGoodsCount(order:GetGoodsHandInCount(index), order:GetGoodsRequiredCount(index))
end

function UIDeliverySimulatorOrderGoodsItem:UpdateGoodsIcon(sprite)
  self.ui.img_icon.sprite = sprite
end

function UIDeliverySimulatorOrderGoodsItem:UpdateGoodsCount(handInCount, requiredCount)
  local isCompeleted = requiredCount <= handInCount
  self.ui.tex_count.gameObject:SetActive(not isCompeleted)
  self.ui.obj_clear:SetActive(isCompeleted)
  if not isCompeleted then
    self.ui.tex_count.text = string.format("%s/%s", tostring(handInCount), tostring(requiredCount))
  end
end

return UIDeliverySimulatorOrderGoodsItem
