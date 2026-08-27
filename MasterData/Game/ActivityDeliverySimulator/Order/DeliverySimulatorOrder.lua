local DeliverySimulatorOrder = class("DeliverySimulatorOrder")

function DeliverySimulatorOrder:ctor(orderCfg, dsCtrl, orderIndex)
  self.orderIndex = orderIndex
  self.cfg = orderCfg
  self.dsCtrl = dsCtrl
  self.endTime = dsCtrl.gameTime - self.cfg.expiration_time
  self.handInGoodsCount = {}
  for index, requiredCount in ipairs(self.cfg.good_value_list) do
    self.handInGoodsCount[index] = 0
  end
end

function DeliverySimulatorOrder:IsComplete()
  for index, requiredCount in ipairs(self.cfg.good_value_list) do
    if self.handInGoodsCount[index] == nil then
      return false
    end
    if requiredCount > self.handInGoodsCount[index] then
      return false
    end
  end
  return true
end

function DeliverySimulatorOrder:IsOverTime()
  return self.dsCtrl.gameTime <= self.endTime
end

function DeliverySimulatorOrder:OrderFail()
  self.dsCtrl.mainWindow:OrderFail(self)
end

function DeliverySimulatorOrder:OrderCompleted()
  self.dsCtrl.mainWindow:OrderCompleted(self)
end

function DeliverySimulatorOrder:HandInGoods(goodsIndex, count)
  if self.cfg == nil then
    return false
  end
  if self.cfg.good_id_list[goodsIndex] == nil then
    return false
  end
  if self.cfg.good_value_list[goodsIndex] == nil then
    return false
  end
  if count > self.cfg.good_value_list[goodsIndex] then
    return false
  end
  self.handInGoodsCount[goodsIndex] = self.handInGoodsCount[goodsIndex] + count
  if self:IsComplete() then
    self:OrderCompleted()
  end
end

function DeliverySimulatorOrder:GetGoodsHandInCount(goodsIndex)
  if self.handInGoodsCount[goodsIndex] == nil then
    return 0
  end
  return self.handInGoodsCount[goodsIndex]
end

function DeliverySimulatorOrder:GetGoodsRequiredCount(goodsIndex)
  if self.cfg == nil then
    return
  end
  return self.cfg.good_value_list[goodsIndex]
end

function DeliverySimulatorOrder:GetRemainingRequiredCount(goodsIndex)
  return math.max(0, self:GetGoodsRequiredCount(goodsIndex) - self:GetGoodsHandInCount(goodsIndex))
end

function DeliverySimulatorOrder:GetOredrReward()
  return self.cfg.reward_num
end

function DeliverySimulatorOrder:GetGoodsSprite(goodsId)
  if self.cfg == nil then
    return
  end
  local atlas = self.dsCtrl:GetDeliveryAtlas()
  return AtlasUtil.GetResldSprite(atlas, ConfigData.delivery_goods_spawn[goodsId].icon)
end

function DeliverySimulatorOrder:GetRemainingTimeRatio()
  if self.endTime == nil then
    return 1
  end
  return (self.dsCtrl.gameTime - self.endTime) / self.cfg.expiration_time
end

return DeliverySimulatorOrder
