local FactoryProcessingData = class("FactoryProcessingData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local FactoryHelper = require("Game.Factory.FactoryHelper")

function FactoryProcessingData:ctor()
  self.uid = nil
  self.id = nil
  self.lineId = nil
  self.num = nil
  self.startTm = nil
  self.endTm = nil
  self._orderCfg = nil
  self._outPutItemCfg = nil
end

function FactoryProcessingData.CreateProcessOrderData(line, uid, processOrderMsg)
  local data = FactoryProcessingData.New()
  data.uid = uid
  data.lineId = line
  data.id = processOrderMsg.id
  data.num = processOrderMsg.num
  data.startTm = processOrderMsg.startTm
  data.endTm = processOrderMsg.endTm
  data:__Preprocess()
  return data
end

function FactoryProcessingData:__Preprocess()
  self._orderCfg = ConfigData.factory_order[self.id]
  if self._orderCfg == nil then
    error("can't read factory_order with id:" .. tostring(self.id))
    return
  end
  self._outPutItemCfg = ConfigData.item[self._orderCfg.outPutItemId]
end

function FactoryProcessingData:GetOutputItemIconName()
  if self._outPutItemCfg == nil then
    return nil
  end
  return self._outPutItemCfg.icon
end

function FactoryProcessingData:GetIsFinish()
  return PlayerDataCenter.timestamp > self.endTm
end

function FactoryProcessingData:GetProcessRate()
  local passedTime = PlayerDataCenter.timestamp - self.startTm
  local totalTime = self.endTm - self.startTm
  return passedTime / totalTime
end

function FactoryProcessingData:GetLeftProcessTime()
  return self.endTm - PlayerDataCenter.timestamp
end

function FactoryProcessingData:GetLeftProcessEnergy()
  local time = self:GetLeftProcessTime()
  return FactoryHelper.GetFactoryTime2EnergyCost(time)
end

function FactoryProcessingData:GetOutputItemProduceNum()
  if self._orderCfg == nil then
    return 0
  end
  return (self._orderCfg.outPutItemNum or 0) * (self.num or 0)
end

function FactoryProcessingData:GetOutputItemCfg()
  return self._outPutItemCfg
end

function FactoryProcessingData:GetIndexAndUid()
  return self.lineId, self.uid
end

function FactoryProcessingData:Delete()
end

return FactoryProcessingData
