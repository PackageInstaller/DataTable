local ActWhiteDayLineData = class("ActWhiteDayLineData")

function ActWhiteDayLineData:ctor(AWDData, lineId)
  self.__AWDData = AWDData
  self.__lineId = lineId
  self.__lineCfg = ConfigData.activity_white_day_line[AWDData:GetActId()][lineId]
  self.__unlockLevel = 1
  self.__isUnlock = false
  self.__assistHeroID = nil
  self.__orderDataList = nil
  self.__isInProduction = false
  self.__inProductionOrderData = nil
  self.__endProductionTm = nil
  self.__isHaveEvent = false
  self.__eventTaskId = false
end

function ActWhiteDayLineData:UpdateWDLineData(orderMsg)
  self.__isUnlock = self.__AWDData:GetWDactoryLineIsUnlock(self.__lineId)
  if orderMsg ~= nil then
    self.__isInProduction = true
    self.__inProductionOrderId = orderMsg.orderId
    self.__inProductionOrderData = self.__AWDData:GetWDOrderData(orderMsg.orderId)
    self.__endProductionTm = orderMsg.endTm
    if orderMsg.heroId == 0 then
      self.__assistHeroID = nil
    else
      self.__assistHeroID = orderMsg.heroId
    end
    self.__isHaveEvent = orderMsg.questId ~= nil and orderMsg.questId ~= 0 and PlayerDataCenter.allTaskData.taskDatas[orderMsg.questId] ~= nil
    self.__eventTaskId = orderMsg.questId
  else
    self.__isInProduction = false
    self.__isHaveEvent = false
  end
end

function ActWhiteDayLineData:GenWDOrderDataList(orderDic)
  local orderList = self:GetWDLineOrderList()
  self.__orderDataList = {}
  for index, orderId in ipairs(orderList) do
    local orderData = orderDic[orderId]
    if orderData ~= nil then
      table.insert(self.__orderDataList, orderData)
    end
  end
  if self.__inProductionOrderId ~= nil then
    self.__inProductionOrderData = self.__AWDData:GetWDOrderData(self.__inProductionOrderId)
  end
end

function ActWhiteDayLineData:SetWDLDAssistHeroID(heroId)
  self.__assistHeroID = heroId
  self.__AWDData:UpdateUnderAssistHeroDic()
end

function ActWhiteDayLineData:GetWDLDLineID()
  return self.__lineId
end

function ActWhiteDayLineData:GetWDLDAssistHeroID()
  return self.__assistHeroID
end

function ActWhiteDayLineData:GetAWDData()
  return self.__AWDData
end

function ActWhiteDayLineData:GetIsWDLUnlock()
  return self.__isUnlock
end

function ActWhiteDayLineData:GetWDLUnlockLevel()
  return self.__AWDData:GetWDactoryLineUnlockLevel(self.__lineId)
end

function ActWhiteDayLineData:GetIsInProduction()
  return self.__isInProduction
end

function ActWhiteDayLineData:GetIsHaveEvent()
  return self.__isHaveEvent and self.__eventTaskId ~= nil and PlayerDataCenter.allTaskData.taskDatas[self.__eventTaskId] ~= nil
end

function ActWhiteDayLineData:GetWDLEventTaksId()
  return self.__eventTaskId
end

function ActWhiteDayLineData:GetInProductionTotalTime()
  return self.__inProductionOrderData:GetWDLineOrderCostTime()
end

function ActWhiteDayLineData:GetInProductionLeftTime()
  local leftTime = math.clamp(self.__endProductionTm - PlayerDataCenter.timestamp, 0, self:GetInProductionTotalTime())
  leftTime = math.ceil(leftTime)
  return leftTime
end

function ActWhiteDayLineData:GetIsProductionOver()
  if not self.__isInProduction then
    return false
  end
  return self:GetInProductionLeftTime() <= 0
end

function ActWhiteDayLineData:GetWDProductionOrderId()
  if self.__isInProduction then
    return self.__inProductionOrderId
  end
end

function ActWhiteDayLineData:GetWDProductionOrderData()
  if self.__inProductionOrderData ~= nil then
    return self.__inProductionOrderData
  end
end

function ActWhiteDayLineData:GetWDLineOrderList()
  return self.__lineCfg.order_list
end

function ActWhiteDayLineData:GetWDLineCfg()
  return self.__lineCfg
end

function ActWhiteDayLineData:GetWDLineOrderDataList()
  return self.__orderDataList
end

return ActWhiteDayLineData
