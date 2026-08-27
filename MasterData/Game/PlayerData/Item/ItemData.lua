local ItemData = class("ItemData")

function ItemData:ctor(dataId, count)
  self.dataId = dataId
  self.__count = count or 1
  local itemCfg = ConfigData.item[self.dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(self.dataId))
    return
  end
  self.itemCfg = itemCfg
  self.type = self.itemCfg.type
  local limitTimeItemCfg = ConfigData.item_time_limit[self.dataId]
  if limitTimeItemCfg ~= nil then
    self.limitTimeItemCfg = limitTimeItemCfg
  end
end

function ItemData:UpdateData(data)
  self:SetCount(data.count)
end

function ItemData:GetCount()
  if self:IsLimitTime() and PlayerDataCenter.timestamp >= self:GetLimitTime() then
    return 0
  end
  return self.__count
end

function ItemData:SetCount(value)
  if self.__count ~= value then
    self.__count = value
    self:OnCountChanged()
  end
end

function ItemData:AddCount(num)
  if num ~= 0 then
    self.__count = self.__count + num
    self:OnCountChanged()
  end
end

function ItemData:OnCountChanged()
end

function ItemData:ContainActionType(actionId)
  return self.itemCfg.action_type == actionId
end

function ItemData:GetActionArg(index)
  return self.itemCfg.arg[index] or 0
end

function ItemData:GetName()
  return LanguageUtil.GetLocaleText(self.itemCfg.name)
end

function ItemData:GetIcon()
  return self.itemCfg.icon
end

function ItemData:GetDescribe()
  return LanguageUtil.GetLocaleText(self.itemCfg.describe)
end

function ItemData:GetColor()
  return ItemQualityColor[self:GetQuality()]
end

function ItemData:GetQuality()
  return self.itemCfg.quality
end

function ItemData:GetItemPrice()
  return self.itemCfg.price
end

function ItemData:IsExplorationHold()
  return self.itemCfg.explorationHold
end

function ItemData:GetItemTopLimit()
  return self.itemCfg.holdlimit
end

function ItemData:IsDynLimitTime()
  return false
end

function ItemData:IsLimitTime()
  return self.limitTimeItemCfg ~= nil
end

function ItemData:GetLimitTime()
  if self.limitTimeItemCfg ~= nil then
    return self.limitTimeItemCfg.time
  end
  return -1
end

function ItemData:GetWareHousePage()
  if self.itemCfg ~= nil then
    return self.itemCfg.warehouse_page
  end
  return 0
end

return ItemData
