local EnergyItemUseView, _ = NewClass("EnergyItemUseView", ItemUseView)

function EnergyItemUseView:_CalcEnergyMaxUseCount()
  local haveEnergy = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.Energy)
  local maxEnergy = DT.GetConstant("Energy_Max")
  local perRecoverEnergy = DT.GetConstant("ReplenishEnergyItemRestoreNum")
  do return math.min, math.floor((maxEnergy - haveEnergy) / perRecoverEnergy), ItemDataUtils.GetItemNum(self._itemId) end
  return math.min, math.floor((maxEnergy - haveEnergy) / perRecoverEnergy), ItemDataUtils.GetItemNum(self._itemId)
end

return EnergyItemUseView
