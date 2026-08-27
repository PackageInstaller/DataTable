local FactoryHelper = class("FactoryHelper")
local FactoryEnum = require("Game.Factory.FactoryEnum")

function FactoryHelper.GetFactoryTime2EnergyCost(time)
  local constant = ConfigData.game_config.factoryEnergy2TimeCons
  return math.ceil(time / constant)
end

function FactoryHelper.ConvertTime2DisplayMode(time)
  local str = "%02d:%02d:%02d"
  local hour = math.floor(time // 3600)
  local min = math.floor(time % 3600 / 60)
  local second = math.floor(time % 60)
  return string.format(str, hour, min, second)
end

function FactoryHelper:CheckOrderResource(orderData, needNum, usedMat, subDic, nowLeftTime, useBagMat)
  local orderCfg = orderData:GetOrderCfg()
  if nowLeftTime >= orderData:GetTimeCost() * needNum then
    nowLeftTime = nowLeftTime - orderData:GetTimeCost() * needNum
  else
    return false, FactoryEnum.eCannotAddReason.timeBeyountLimit
  end
  local factoryCtrl = ControllerManager:GetController(ControllerTypeId.Factory, true)
  for itemId, cost in pairs(orderCfg.raw_material) do
    local nowCount = self:GetPlayerItemCount(itemId) - (usedMat[itemId] or 0)
    local nowCost = cost * needNum
    if nowCount < nowCost then
      local subOrderCfg
      for _, orderId in ipairs(ConfigData.factory_order.orderMap[orderCfg.id].sudOrderListIds) do
        if ConfigData.factory_order[orderId].outPutItemId == itemId and factoryCtrl.OrderDataDic[orderId]:GetIsUnlock() then
          subOrderCfg = ConfigData.factory_order[orderId]
          break
        end
      end
      if subOrderCfg ~= nil then
        local needNum = math.ceil((nowCost - nowCount) / subOrderCfg.outPutItemNum)
        local remainNum = needNum * subOrderCfg.outPutItemNum - (nowCost - nowCount)
        local couldSub, arg2 = FactoryHelper.CheckOrderResource(self, factoryCtrl.OrderDataDic[subOrderCfg.id], needNum, usedMat, subDic, nowLeftTime, useBagMat)
        if not couldSub then
          return false, arg2
        else
          subDic[subOrderCfg.id] = (subDic[subOrderCfg.id] or 0) + needNum
          usedMat[itemId] = (usedMat[itemId] or 0) + nowCount - remainNum
          nowLeftTime = arg2
        end
      else
        return false, FactoryEnum.eCannotAddReason.matInsufficeient
      end
      useBagMat[itemId] = -1
    else
      usedMat[itemId] = (usedMat[itemId] or 0) + nowCost
      local lastConsume = useBagMat[itemId] or 0
      if 0 <= lastConsume then
        useBagMat[itemId] = lastConsume + nowCost
      end
    end
  end
  return true, nowLeftTime
end

return FactoryHelper
