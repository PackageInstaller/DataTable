local ActWhiteDayLineOrderData = class("ActWhiteDayLineOrderData")

function ActWhiteDayLineOrderData:ctor(AWDData, orderId)
  self.__AWDData = AWDData
  self.__orderId = orderId
  self.__orderCfg = ConfigData.activity_white_day_order[orderId]
  self.__IsUnlock = false
  for itemId, itemNum in pairs(self.__orderCfg.product) do
    self.__itemId = itemId
    self.__itemNum = itemNum
    if itemId ~= nil then
      self.__itemCfg = ConfigData.item[itemId]
    end
    break
  end
end

function ActWhiteDayLineOrderData:UpdateWDLineOrderData()
  self.__IsUnlock = self.__AWDData:GetAWDFactoryLevel() >= self.__orderCfg.unlock_level
end

function ActWhiteDayLineOrderData:GetWDAWDData()
  return self.__AWDData
end

function ActWhiteDayLineOrderData:GetWDLineOrderId()
  return self.__orderId
end

function ActWhiteDayLineOrderData:GetWDLineOrderIsUnlock()
  return self.__IsUnlock
end

function ActWhiteDayLineOrderData:GetWDLineOrderCouldShow()
  return self.__IsUnlock and self:GetWDLineOrderUsedTime() < self:GetWDLineOrderTotalUseTime()
end

function ActWhiteDayLineOrderData:GetWDLineOrderUnlockLevel()
  return self.__orderCfg.unlock_level
end

function ActWhiteDayLineOrderData:GetWDLineOrderUsedTime()
  return self.__AWDData:GetWDOrderUsedTime(self.__orderId)
end

function ActWhiteDayLineOrderData:GetWDLineOrderTotalUseTime()
  return self.__orderCfg.max_time
end

function ActWhiteDayLineOrderData:GetWDLineOrderName()
  return LanguageUtil.GetLocaleText(self.__itemCfg.name)
end

function ActWhiteDayLineOrderData:GetWDLineOrderCostTime()
  return self.__orderCfg.time_cost
end

function ActWhiteDayLineOrderData:GetWDLineOrderExp()
  return self.__orderCfg.order_exp
end

function ActWhiteDayLineOrderData:GetWDOrderItemId()
  return self.__itemId
end

function ActWhiteDayLineOrderData:GetWDOrderItemIdAndNum()
  return self.__itemCfg, self.__itemNum
end

function ActWhiteDayLineOrderData:GetWDOrderRewardDic()
  return self.__orderCfg.product
end

return ActWhiteDayLineOrderData
