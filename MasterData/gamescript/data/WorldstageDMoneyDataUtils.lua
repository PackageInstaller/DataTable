local WorldstageDMoneyDataUtils = {}

function WorldstageDMoneyDataUtils.GetGold()
  return DataCenter.playerData.DMoney.gold
end

function WorldstageDMoneyDataUtils.GetExclusiveGold()
  return DataCenter.playerData.DMoney.exclusiveGold
end

function WorldstageDMoneyDataUtils.SetGold(numVal)
  if not numVal or type(numVal) ~= "number" then
    return
  end
  DataCenter.playerData.DMoney.gold = numVal
  EventMgr.Instance.OnDMoneyGoldChange:Dispatch()
end

function WorldstageDMoneyDataUtils.SetExclusiveGold(numVal)
  if not numVal or type(numVal) ~= "number" then
    return
  end
  DataCenter.playerData.DMoney.exclusiveGold = numVal
end

return WorldstageDMoneyDataUtils
