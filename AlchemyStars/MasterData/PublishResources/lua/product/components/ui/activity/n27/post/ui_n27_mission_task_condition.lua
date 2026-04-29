_class("UIN27MissionTaskCondition", Object)
UIN27MissionTaskCondition = UIN27MissionTaskCondition

function UIN27MissionTaskCondition:Constructor()
end

function UIN27MissionTaskCondition:CheckTaskAndGetStr(task, curOrderMap)
  local taskCondition = string.split(task.Condition, ",")
  for i = 1, #taskCondition do
    taskCondition[i] = tonumber(taskCondition[i])
  end
  local str = StringTable.Get(task.Desc)
  local typeID = taskCondition[1]
  if typeID == 3500 then
    local count = taskCondition[3]
    return self:FinishOrderCountStr(str, count, curOrderMap)
  elseif typeID == 3503 then
    local type = taskCondition[3]
    local id = taskCondition[4]
    local count = taskCondition[5]
    return self:OrderContainsItemStr(str, type, id, count, curOrderMap)
  elseif typeID == 3502 then
    local petID = taskCondition[3]
    local percent = taskCondition[4]
    return self:FinishPetOrder(str, petID, percent, curOrderMap)
  elseif typeID == 3501 then
    local percent = taskCondition[3]
    return self:FinishPercent(str, percent, curOrderMap)
  end
end

function UIN27MissionTaskCondition:FinishOrderCountStr(str, count, curOrderMap)
  local orderCount = table.count(curOrderMap)
  local done = count <= orderCount
  return string.format("%s<color=#DCA42B>(%d/%d)</color>", str, orderCount, count), done
end

function UIN27MissionTaskCondition:GetOrderItemTypeCount(orderID, orderMap, typeId)
  local orderCfg = Cfg.cfg_component_post_station_game_mission_order({ID = orderID})[1]
  local itemTypeMap = {}
  for itemID, itemCount in pairs(orderMap) do
    local itemCfg = Cfg.cfg_component_post_station_game_item({ID = itemID})[1]
    local itemType = itemCfg.ItemType
    itemTypeMap[itemType] = itemTypeMap[itemType] or 0
    itemTypeMap[itemType] = itemTypeMap[itemType] + itemCount
  end
  local curCount = 0
  local itemIdAndNum = orderCfg.ItemIdAndNum or {}
  local itemTypeAndNum = orderCfg.ItemTypeAndNum or {}
  for _, v in pairs(itemIdAndNum) do
    local itemCfg = Cfg.cfg_component_post_station_game_item({
      ID = v[1]
    })[1]
    local itemType = itemCfg.ItemType
    if itemType == typeId then
      local haveCount = orderMap[v[1]] or 0
      haveCount = haveCount > v[2] and v[2] or haveCount
      curCount = curCount + haveCount
    end
  end
  for _, v in pairs(itemTypeAndNum) do
    if v[1] == typeId then
      local haveCount = itemTypeMap[typeId] or 0
      haveCount = haveCount > v[2] and v[2] or haveCount
      curCount = curCount + haveCount
    end
  end
  return curCount
end

function UIN27MissionTaskCondition:GetOrderItemCount(orderID, orderMap, itemId)
  local orderCfg = Cfg.cfg_component_post_station_game_mission_order({ID = orderID})[1]
  local curCount = 0
  local itemIdAndNum = orderCfg.ItemIdAndNum or {}
  local itemTypeAndNum = orderCfg.ItemTypeAndNum or {}
  local itemCfg = Cfg.cfg_component_post_station_game_item({ID = itemId})[1]
  local itemType = itemCfg.ItemType
  local haveCount = orderMap[itemId] or 0
  for _, v in pairs(itemIdAndNum) do
    if v[1] == itemId then
      haveCount = haveCount > v[2] and v[2] or haveCount
      curCount = curCount + haveCount
    end
  end
  for _, v in pairs(itemTypeAndNum) do
    if v[1] == itemType then
      haveCount = haveCount > v[2] and v[2] or haveCount
      curCount = curCount + haveCount
    end
  end
  return curCount
end

function UIN27MissionTaskCondition:OrderContainsItemStr(str, type, id, needCount, curOrderMap)
  local curCount = 0
  for orderID, orderMap in pairs(curOrderMap) do
    if type == 0 then
      curCount = curCount + self:GetOrderItemCount(orderID, orderMap, id)
    else
      curCount = curCount + self:GetOrderItemTypeCount(orderID, orderMap, id)
    end
  end
  curCount = needCount < curCount and needCount or curCount
  local done = curCount == needCount
  return string.format("%s<color=#DCA42B>(%d/%d)</color>", str, curCount, needCount), done
end

function UIN27MissionTaskCondition:FinishPetOrder(str, petID, percent, curOrderMap)
  local petFinish = 0
  for orderID, orderMap in pairs(curOrderMap) do
    local orderCfg = Cfg.cfg_component_post_station_game_mission_order({ID = orderID})[1]
    if orderCfg.PetId == petID then
      local finishPercent = self:GetOrderFinishPercent(orderID, orderMap)
      if percent <= finishPercent then
        petFinish = 1
      end
    end
  end
  local done = petFinish == 1
  return string.format("%s<color=#DCA42B>(%d/%d)</color>", str, petFinish, 1), done
end

function UIN27MissionTaskCondition:FinishPercent(str, percent, curOrderMap)
  local orderPercentMap = {}
  for orderID, orderMap in pairs(curOrderMap) do
    local per = self:GetOrderFinishPercent(orderID, orderMap)
    table.insert(orderPercentMap, per)
  end
  local all = 0
  for _, v in pairs(orderPercentMap) do
    all = all + v
  end
  local per = #orderPercentMap == 0 and 0 or math.floor(all / #orderPercentMap)
  local done = percent <= per
  return string.format("%s<color=#DCA42B>(%d%%/%d%%)</color>", str, per, percent), done
end

function UIN27MissionTaskCondition:GetOrderFinishPercent(orderID, orderMap)
  local orderCfg = Cfg.cfg_component_post_station_game_mission_order({ID = orderID})[1]
  local itemTypeMap = {}
  for itemID, itemCount in pairs(orderMap) do
    local itemCfg = Cfg.cfg_component_post_station_game_item({ID = itemID})[1]
    local itemType = itemCfg.ItemType
    itemTypeMap[itemType] = itemTypeMap[itemType] or 0
    itemTypeMap[itemType] = itemTypeMap[itemType] + itemCount
  end
  local haveCount = 0
  local needCount = 0
  local itemTypeAndNum = orderCfg.ItemTypeAndNum or {}
  local itemIdAndNum = orderCfg.ItemIdAndNum or {}
  for _, v in pairs(itemTypeAndNum) do
    local type = v[1]
    local curNeedCount = v[2]
    local curHaveCount = itemTypeMap[type] and itemTypeMap[type] or 0
    curHaveCount = curNeedCount < curHaveCount and curNeedCount or curHaveCount
    haveCount = haveCount + curHaveCount
    needCount = needCount + curNeedCount
  end
  for _, v in pairs(itemIdAndNum) do
    local itemID = v[1]
    local curNeedCount = v[2]
    local curHaveCount = orderMap[itemID] and orderMap[itemID] or 0
    curHaveCount = curNeedCount < curHaveCount and curNeedCount or curHaveCount
    haveCount = haveCount + curHaveCount
    needCount = needCount + curNeedCount
  end
  return math.floor(haveCount / needCount * 100)
end
