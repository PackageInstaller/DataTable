local base = require("Game.PlayerData.Item.ItemData")
local LimitTimeItemData = class("ItemData", base)

function LimitTimeItemData:ctor(dataId, stackInfos)
  self.dataId = dataId
  self:UpdateStackInfos(stackInfos)
  local itemCfg = ConfigData.item[self.dataId]
  if itemCfg == nil then
    error("item cfg is null,Id:" .. tostring(self.dataId))
    return
  end
  self.itemCfg = itemCfg
  self.type = self.itemCfg.type
  local limitTimeItemCfg = ConfigData.item_time_limit[self.dataId]
  if limitTimeItemCfg == nil then
    error("limitTimeItemCfg cfg is null,Id:" .. tostring(self.dataId))
    return
  end
  self.limitTimeItemCfg = limitTimeItemCfg
end

function LimitTimeItemData:UpdateStackInfos(stackInfos)
  self.__stackInfos = stackInfos
  local curTime = PlayerDataCenter.timestamp
  local tempCount = 0
  self.__stackCount = 0
  for i = #stackInfos, 1, -1 do
    if curTime <= stackInfos[i].time then
      tempCount = tempCount + stackInfos[i].num
      self.__stackCount = self.__stackCount + 1
    else
      table.remove(self.__stackInfos, i)
    end
  end
  table.sort(self.__stackInfos, function(a, b)
    if a.time ~= b.time then
      return a.time < b.time
    end
    return false
  end)
  if self.__count ~= tempCount then
    self.__count = tempCount
    self:OnCountChanged()
  end
end

function LimitTimeItemData:UpdateData()
end

function LimitTimeItemData:GetCount()
  local count = 0
  local curTime = PlayerDataCenter.timestamp
  for k, v in pairs(self.__stackInfos) do
    if curTime < v.time then
      count = count + v.num
    end
  end
  return count
end

function LimitTimeItemData:SetCount(value)
end

function LimitTimeItemData:AddCount(num)
end

function LimitTimeItemData:GetStackInfoByIndex(index)
  if self.__stackInfos ~= nil then
    return self.__stackInfos[index]
  end
  return nil
end

function LimitTimeItemData:GetLimitTime()
  return -1
end

function LimitTimeItemData:GetSingStackCount(index)
  local stackInfo = self:GetStackInfoByIndex(index)
  if stackInfo ~= nil then
    return stackInfo.count
  end
  return -1
end

function LimitTimeItemData:GetLimitTime(index)
  local stackInfo = self:GetStackInfoByIndex(index)
  if stackInfo ~= nil then
    return stackInfo.time
  end
  return -1
end

function LimitTimeItemData:IsDynLimitTime()
  return true
end

function LimitTimeItemData:GetStackCount()
  return self.__stackCount
end

return LimitTimeItemData
