local GetEnergyCheckUtils = System.NewClass("GetEnergyCheckUtils")

function GetEnergyCheckUtils.EnergyIsOverMax(AddValue)
  local maxStoreEnergy = PlayerDataUtils.GetMaxStoreEnergy()
  local currEnergy = PlayerDataUtils.GetEnergy()
  return maxStoreEnergy < currEnergy + AddValue
end

function GetEnergyCheckUtils.TipsShow(func)
  local tipsId = 20088
  local maxStoreEnergy = PlayerDataUtils.GetMaxStoreEnergy()
  local desc = LT.Textf(DT.TipsType[tipsId].Desc, maxStoreEnergy)
  Alert.Show(tipsId, nil, func, nil, desc)
end

function GetEnergyCheckUtils.CompleteAwardCheckEnergyOver(completeAward)
  if not completeAward or 0 == #completeAward then
    return false
  end
  local energyItemId = DT.GetConstant("EnergyItemTid")
  local energyItemNum = 0
  for _tid, _num in table.iteraDouble(completeAward) do
    if _tid == energyItemId then
      energyItemNum = energyItemNum + _num
    end
  end
  return energyItemNum > 0 and GetEnergyCheckUtils.EnergyIsOverMax(energyItemNum) or false
end

function GetEnergyCheckUtils.TaskConfigCheckEnergyOver(taskConfig)
  if taskConfig and taskConfig.CompleteAward then
    do return GetEnergyCheckUtils.CompleteAwardCheckEnergyOver end
    return GetEnergyCheckUtils.CompleteAwardCheckEnergyOver, taskConfig.CompleteAward
  end
  return false
end

return GetEnergyCheckUtils
