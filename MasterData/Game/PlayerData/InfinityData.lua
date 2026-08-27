local InfinityData = class("InfinityData")

function InfinityData:ctor()
  self.sectorCompleteDic = {}
  self.processingLevel = {}
  self.jumpLevelInfo = {}
end

function InfinityData:InitInfinityData(highest, processing)
  if highest ~= nil then
    for _sectorId, dungeonId in pairs(highest) do
      local sectorId, index = self:__GetInfinityDungeonInfo(dungeonId)
      if _sectorId ~= sectorId then
        error("server infinity sectorId:" .. tostring(_sectorId) .. " local infinty sectorId:" .. tostring(sectorId))
      end
      self.sectorCompleteDic[sectorId] = index
    end
  end
  if processing ~= nil then
    table.merge(self.processingLevel, processing)
  end
end

function InfinityData:UpdateInfinityData(completed, processingUpdate)
  if completed ~= nil then
    for dungeonId, _ in pairs(completed) do
      local sectorId, index = self:__GetInfinityDungeonInfo(dungeonId)
      if self.sectorCompleteDic[sectorId] ~= nil then
        if index - self.sectorCompleteDic[sectorId] > 1 then
          self:__GenJumpLevelInfo(sectorId, index)
        end
        self.sectorCompleteDic[sectorId] = index
      else
        if 1 < index then
          self:__GenJumpLevelInfo(sectorId, index)
        end
        self.sectorCompleteDic[sectorId] = index
      end
    end
  end
  if processingUpdate ~= nil then
    table.merge(self.processingLevel, processingUpdate)
  end
end

function InfinityData:IsInfinityDungeonCompleted(dungeonId)
  local sectorId, index = self:__GetInfinityDungeonInfo(dungeonId)
  if self.sectorCompleteDic[sectorId] ~= nil and index <= self.sectorCompleteDic[sectorId] then
    return true
  end
  return false
end

function InfinityData:GetInfinityDungeonProcess(dungeonId)
  if self.processingLevel ~= nil and self.processingLevel[dungeonId] ~= nil then
    return self.processingLevel[dungeonId]
  end
end

function InfinityData:GetCompletedInfinityLevelNum()
  local num = 0
  for sectorId, maxIndex in pairs(self.sectorCompleteDic) do
    num = num + maxIndex
  end
  return num
end

function InfinityData:GetJumpLevelReward(sectorId)
  if self.jumpLevelInfo[sectorId] ~= nil then
    return self.jumpLevelInfo[sectorId].items
  end
end

function InfinityData:CleanJumpLevelReward(sectorId)
  self.jumpLevelInfo[sectorId] = nil
end

function InfinityData:__GetInfinityDungeonInfo(dungeonId)
  local levelDicCfg = ConfigData.endless.levelDic[dungeonId]
  if levelDicCfg ~= nil then
    return levelDicCfg.sectorId, levelDicCfg.index
  end
end

function InfinityData:__GenJumpLevelInfo(sectorId, freshIndex)
  local info = {}
  local items = {}
  local oldHeighestIndex = self.sectorCompleteDic[sectorId] or 1
  for index = oldHeighestIndex + 1, freshIndex do
    local endlessCfg = ConfigData.endless[sectorId][index]
    local dungeonId = endlessCfg.id
    local startLayer = 1
    if self.processingLevel[dungeonId] ~= nil then
      info[dungeonId] = self.processingLevel[dungeonId]
      startLayer = self.processingLevel[dungeonId] + 1
    else
      info[dungeonId] = true
      startLayer = 1
    end
    for i = startLayer, #endlessCfg.layer do
      local layerId = endlessCfg.layer[i]
      if layerId == nil then
        error("layerId is nil ,sectorId=" .. tostring(sectorId) .. " index=" .. tostring(i))
      else
        local layerCfg = ConfigData.endless_layer[layerId]
        if layerCfg == nil then
          error("layerCfg is nil with id=" .. tostring(layerId))
          goto lbl_84
        else
          for index, itemId in ipairs(layerCfg.reward_itemIds) do
            if items[itemId] ~= nil then
              items[itemId] = items[itemId] + layerCfg.reward_itemNums[index]
            else
              items[itemId] = layerCfg.reward_itemNums[index]
            end
          end
        end
      end
      ::lbl_84::
    end
    for index, itemId in ipairs(endlessCfg.clear_reward_itemIds) do
      if items[itemId] ~= nil then
        items[itemId] = items[itemId] + endlessCfg.clear_reward_itemNums[index]
      else
        items[itemId] = endlessCfg.clear_reward_itemNums[index]
      end
    end
  end
  self.jumpLevelInfo[sectorId] = {info = info, items = items}
end

function InfinityData:GetCanCompleteInfinityMinPower()
  local endlessCfg
  for _, sectorId in ipairs(ConfigData.sector.id_sort_list) do
    local _, _, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
    if actFrameData == nil and PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId) and ConfigData.endless[sectorId] ~= nil then
      local nowCompleteIndex = self.sectorCompleteDic[sectorId]
      if nowCompleteIndex == nil then
        nowCompleteIndex = 5
      else
        nowCompleteIndex = nowCompleteIndex + 5
        nowCompleteIndex = nowCompleteIndex - nowCompleteIndex % 5
      end
      local tempEndlessCfg = ConfigData.endless[sectorId][nowCompleteIndex]
      if tempEndlessCfg ~= nil and (endlessCfg == nil or endlessCfg.combat > tempEndlessCfg.combat) then
        endlessCfg = tempEndlessCfg
      end
    end
  end
  return endlessCfg
end

function InfinityData:GetLastInfinityCfg()
  local endlessCfg
  for sectorIndex = #ConfigData.sector.id_sort_list, 1, -1 do
    local sectorId = ConfigData.sector.id_sort_list[sectorIndex]
    local _, _, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
    if actFrameData == nil and PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId) and ConfigData.endless[sectorId] ~= nil then
      local nowCompleteIndex = self.sectorCompleteDic[sectorId]
      if nowCompleteIndex ~= nil then
        local tempEndlessCfg = ConfigData.endless[sectorId][nowCompleteIndex]
        if tempEndlessCfg ~= nil then
          endlessCfg = tempEndlessCfg
          break
        end
      end
    end
  end
  return endlessCfg
end

return InfinityData
