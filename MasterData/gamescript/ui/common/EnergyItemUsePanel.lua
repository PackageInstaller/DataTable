local EnergyItemUsePanel, Super = System.NewClass("EnergyItemUsePanel", ItemUsePanel)
EnergyItemUsePanel.uiResCls = UI_Shop_Popup_TipsResource

function EnergyItemUsePanel:ctor(itemId, afterUseCallback)
  Super.ctor(self, itemId, afterUseCallback)
  self.maxUseCount = self:GetMaxBuyCount()
end

function EnergyItemUsePanel:GetMaxBuyCount()
  local haveEnergy = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.Energy)
  local maxEnergy = DT.GetConstant("Energy_Max")
  local perRecoverEnergy = DT.GetConstant("ReplenishEnergyItemRestoreNum")
  do return math.min, math.floor((maxEnergy - haveEnergy) / perRecoverEnergy), ItemDataUtils.GetItemNum(self.itemId) end
  return math.min, math.floor((maxEnergy - haveEnergy) / perRecoverEnergy), ItemDataUtils.GetItemNum(self.itemId)
end

return EnergyItemUsePanel
