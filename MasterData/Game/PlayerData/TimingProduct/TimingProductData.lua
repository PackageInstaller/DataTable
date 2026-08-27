local TimingProductData = class("TimingProductData")
local cs_MessageCommon = CS.MessageCommon

function TimingProductData:ctor(msg)
  self.id = msg.id
  self.moduleId = msg.moduleId
  self:UpdTimingProductData(msg)
end

function TimingProductData:UpdTimingProductData(msg)
  self.itemId = msg.itemId
  self.itemNum = msg.itemNum
  self.refreshTm = msg.refreshTm
  self.realNum = msg.realNum
end

function TimingProductData:IsTmProductTimeUp(timestamp)
  return timestamp >= self.refreshTm
end

function TimingProductData:GetTmProductRefreshTm()
  return self.refreshTm
end

function TimingProductData:CanTmProductRes(withTips, fullWareHouseItemDic)
  local itemCfg = ConfigData.item[self.itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(self.itemId))
    return false
  end
  local capacity = itemCfg.holdlimit
  local playerResCount = PlayerDataCenter:GetItemCount(self.itemId)
  local fullWarehouse = capacity < playerResCount + self.realNum
  local name = LanguageUtil.GetLocaleText(itemCfg.name)
  if fullWarehouse then
    if withTips then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ItemInWarehouseFull, name), true)
    end
    if fullWareHouseItemDic ~= nil then
      fullWareHouseItemDic[name] = true
    end
  end
  return not fullWarehouse
end

return TimingProductData
