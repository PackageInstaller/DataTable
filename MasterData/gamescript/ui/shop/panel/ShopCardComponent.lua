local ShopCardComponent, Super = System.NewComponent("ShopCardComponent")

function ShopCardComponent:ctor(res, uid, configId, selected, cost, battleDesc, offCostColor, showUpgradeTip)
  Super.ctor(self)
  self.ui = ShopCardItemResource(res)
  self.uid = uid
  self.configId = configId
  self.selected = selected or false
  self.battleDesc = battleDesc
  self.cost = cost
  self.offCostColor = offCostColor
  self.showUpgradeTip = showUpgradeTip
end

function ShopCardComponent:OnBind(binder)
  self.binder = binder
  self.cardBase = binder:BindComponent(CardBaseComponent(self.ui.Component_CardItem, self.uid, self.configId, self.selected, self.cost, self.battleDesc, self.offCostColor, self.showUpgradeTip))
  self.ui.CostInfo:SetActive(false)
  self.ui.GroupDiscount:SetActive(false)
end

function ShopCardComponent:SetClickCallback(callback)
  if self.cardBase then
    self.cardBase:SetClickCallback(callback)
  end
end

function ShopCardComponent:SetLongPressedCallback(callback)
  if self.cardBase then
    self.cardBase:SetLongPressedCallback(callback)
  end
end

function ShopCardComponent:SetSelectShow(bool)
  if self.cardBase then
    self.cardBase:SetSelectShow(bool)
  end
end

function ShopCardComponent:SetSelectFunc()
  if self.cardBase then
    self.cardBase:SetSelectFunc()
  end
end

function ShopCardComponent:SetIsDeleted(isDeleted)
end

function ShopCardComponent:ResetCardId(configId)
  if self.cardBase then
    self.cardBase:ResetCardId(configId)
  end
end

function ShopCardComponent:SetCardDesc(desc)
  if self.cardBase then
    self.cardBase:SetCardDesc(desc)
  end
end

function ShopCardComponent:CheckConfigValid()
  if self.cardBase then
    self.cardBase:CheckConfigValid()
  end
end

return ShopCardComponent
