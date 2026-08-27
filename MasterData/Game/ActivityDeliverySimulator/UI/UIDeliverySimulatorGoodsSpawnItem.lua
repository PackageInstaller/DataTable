local base = UIBaseNode
local UIDeliverySimulatorGoodsSpawnItem = class("UIDeliverySimulatorGoodsSpawnItem", base)

function UIDeliverySimulatorGoodsSpawnItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIDeliverySimulatorGoodsSpawnItem:InitDeliverySimulatorGoodsSpawnItem()
end

function UIDeliverySimulatorGoodsSpawnItem:UpdateUIPos(position)
  local anchorPos = UIManager:World2UIPosition(position)
  self.transform.anchoredPosition = anchorPos
end

function UIDeliverySimulatorGoodsSpawnItem:UpdateGoodsSpawnProgress(progress)
  if self.ui.img_Progress.fillAmount < 1 and 1 <= progress then
    self:PlayReplenishmentAnim(1 <= progress)
  end
  self.ui.img_Progress.fillAmount = progress
end

function UIDeliverySimulatorGoodsSpawnItem:SwitchState(hasGoods)
  self.ui.obj_ItemCd:SetActive(not hasGoods)
  self.ui.obj_ItemGet:SetActive(hasGoods)
end

function UIDeliverySimulatorGoodsSpawnItem:PlayTouchAnim()
end

function UIDeliverySimulatorGoodsSpawnItem:PlayExitAnim()
end

function UIDeliverySimulatorGoodsSpawnItem:PlayPickUpAnim()
end

function UIDeliverySimulatorGoodsSpawnItem:PlayReplenishmentAnim(play)
end

function UIDeliverySimulatorGoodsSpawnItem:OnDelete()
end

return UIDeliverySimulatorGoodsSpawnItem
