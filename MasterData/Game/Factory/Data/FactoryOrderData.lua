local FactoryOrderData = class("FactoryOrderData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local factoryEnergyItemId = ConfigData.game_config.factoryEnergyItemId
local FactoryHelper = require("Game.Factory.FactoryHelper")

function FactoryOrderData.CreateOrderData(orderCfg, isRoomUnlock)
  local FactoryOrderData = FactoryOrderData.New()
  FactoryOrderData.orderCfg = orderCfg
  FactoryOrderData.orderRoomIndex = orderCfg.type
  FactoryOrderData.isUnlock = CheckCondition.CheckLua(orderCfg.pre_condition, orderCfg.pre_para1, orderCfg.pre_para2)
  FactoryOrderData.isRoomUnlock = isRoomUnlock
  FactoryOrderData.efficiencyEnhance = PlayerDataCenter.playerBonus:GetFactoryEfficiency(orderCfg.id)
  FactoryOrderData.timeCost = math.ceil(orderCfg.time_cost * (1 - FactoryOrderData.efficiencyEnhance / 1000))
  if orderCfg.type == 1 then
    FactoryOrderData.orderType = FactoryEnum.eOrderType.dig
  else
    FactoryOrderData.orderType = FactoryEnum.eOrderType.product
  end
  return FactoryOrderData
end

function FactoryOrderData:ctor()
  self.orderCfg = nil
  self.orderType = nil
  self.orderRoomIndex = nil
  self.isUnlock = false
  self.isRoomUnlock = false
  self.efficiencyEnhance = nil
  self.timeCost = nil
end

function FactoryOrderData:UpdateOrderData()
  self:UpdateIsUnlcok()
  if self.isUnlock then
    self:UpdateEfficiencyEnhance()
  end
end

function FactoryOrderData:UpdateEfficiencyEnhance()
  self.efficiencyEnhance = PlayerDataCenter.playerBonus:GetFactoryEfficiency(self.orderCfg.id)
  if self.efficiencyEnhance == nil then
    return
  end
  self.timeCost = math.ceil(self.orderCfg.time_cost * (1 - self.efficiencyEnhance / 1000))
end

function FactoryOrderData:UpdateIsUnlcok()
  self.isUnlock = CheckCondition.CheckLua(self.orderCfg.pre_condition, self.orderCfg.pre_para1, self.orderCfg.pre_para2)
end

function FactoryOrderData:UpdateIsRoomUnlock(bool)
  self.isRoomUnlock = bool
end

function FactoryOrderData:GetIsWhareHouseNotFull(curOrderNum)
  local curwarehouseNum = PlayerDataCenter:GetItemCount(self.orderCfg.outPutItemId, false)
  local warehouseCapacity = PlayerDataCenter.playerBonus:GetWarehouseCapcity(self.orderCfg.outPutItemId)
  if warehouseCapacity == 0 then
    local itemCfg = ConfigData.item[self.orderCfg.outPutItemId]
    if itemCfg == nil or itemCfg.holdlimit == nil then
      error("can't read itemCfg/itemCfg.holdlimit with id = " .. tostring(self.orderCfg.outPutItemId))
    else
      warehouseCapacity = itemCfg.holdlimit
    end
  end
  local warehouseNotFull = warehouseCapacity == 0 or warehouseCapacity - curwarehouseNum >= (curOrderNum + 1) * self.orderCfg.outPutItemNum
  return warehouseNotFull
end

function FactoryOrderData:GetIsUnlock()
  return self.isRoomUnlock and self.isUnlock
end

function FactoryOrderData:GetTimeCost()
  return self.timeCost
end

function FactoryOrderData:GetOrderCfg()
  return self.orderCfg
end

function FactoryOrderData:GetOrderType()
  return self.orderType
end

function FactoryOrderData:GetOrderRoomIndex()
  return self.orderRoomIndex
end

function FactoryOrderData:GetCouldProdunc(factoryController)
  if not self:GetIsUnlock() then
    return false
  end
  return FactoryHelper.CheckOrderResource(self, self, 1, {}, {}, ConfigData.game_config.factoryTimeCostLimit, {})
end

function FactoryOrderData:GetPlayerItemCount(itemId)
  local originCount = PlayerDataCenter:GetItemCount(itemId)
  return originCount
end

function FactoryOrderData:Delete()
end

return FactoryOrderData
