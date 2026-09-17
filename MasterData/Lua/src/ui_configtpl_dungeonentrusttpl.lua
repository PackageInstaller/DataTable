local this = class("dungeonEntrustTpl")

function this:init(config)
  self.data = config
  self.modeInfo = {}
  self.dungeonIdLookup = {}
  self.GroupMap = {}
  local groupIdToIndex = {}
  for _, v in pairs(config) do
    if not groupIdToIndex[v.groupId] then
      groupIdToIndex[v.groupId] = #self.modeInfo + 1
      table.insert(self.modeInfo, {
        groupId = v.groupId,
        levelInfos = {}
      })
    end
    table.insert(self.modeInfo[groupIdToIndex[v.groupId]].levelInfos, v)
    self.dungeonIdLookup[v.dungeonId] = v
    if self.GroupMap[v.groupId] == nil then
      self.GroupMap[v.groupId] = {}
    end
    table.insert(self.GroupMap[v.groupId], {
      id = v.id
    })
  end
  for _, v2 in ipairs(self.modeInfo) do
    table.sort(v2.levelInfos, function(a, b)
      if a.sortId == b.sortId then
        return a.id < b.id
      end
      return a.sortId < b.sortId
    end)
  end
  self.runeDungeonMap = {}
  for dungeonId, v in pairs(config) do
    if v.rewardShow then
      for key, RewardItem in ipairs(L_DataUtil.parseRangeRewardConfig(v.rewardShow)) do
        if self.runeDungeonMap[RewardItem.itemId] == nil then
          self.runeDungeonMap[RewardItem.itemId] = {}
        end
        table.insert(self.runeDungeonMap[RewardItem.itemId], {dungeonId = dungeonId})
      end
    end
  end
  for _, v2 in pairs(self.GroupMap) do
    table.sort(v2, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:getGroupById(groupId)
  return self.GroupMap[groupId]
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getRuneDungeonMap()
  return self.runeDungeonMap
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByDungeonId(id)
  return self.dungeonIdLookup[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getEntrustNpcName(tpl)
  return L_Config:provider(tpl.entrustNpc)
end

function this:getIntroduce(tpl)
  return L_Config:provider(tpl.introduce)
end

function this:getDungeonId(tpl)
  return tpl.dungeonId
end

function this:getRewardShow(tpl)
  return L_DataUtil.parseRangeRewardConfig(tpl.rewardShow)
end

function this:getOneStarRewardShow(tpl)
  return L_DataUtil.parseRewardConfig(tpl.starRewardShow1)
end

function this:getTwoStarRewardShow(tpl)
  return L_DataUtil.parseRewardConfig(tpl.starRewardShow2)
end

function this:getThreeStarRewardShow(tpl)
  return L_DataUtil.parseRewardConfig(tpl.starRewardShow3)
end

function this:getMainRewardShow(tpl)
  if not tpl.mainReward then
    return nil
  end
  return L_DataUtil.parseRewardConfigNoNum(tpl.mainReward)
end

function this:getTaskShow(tpl)
  return tpl.taskShow
end

function this:getTaskUnlock(tpl)
  return tpl.taskUnlock
end

function this:getTag(tpl)
  return tpl.Tag
end

function this:getRecommendLevel(tpl)
  return tpl.level
end

function this:getDungeonTarget(tpl)
  return L_Config:provider(tpl.dungeonTarget)
end

function this:getDifficultyNum()
  return 1
end

function this:getInfoByDifficulty(difficulty)
  return self.modeInfo
end

function this:getModeInfo()
  return self.modeInfo
end

function this:getEnergyConsume(tpl)
  return tpl.stamina
end

function this:getAreaIdByTpl(tpl)
  return tpl.areaId
end

function this:getSubName(tpl)
  return tpl.subName
end

function this:enumEntrustsByReward(itemType, itemId, processor)
  for id, v in pairs(self.data) do
    local rewards = L_DataUtil.parseRangeRewardConfig(v.rewardShow)
    for _, reward in ipairs(rewards) do
      if reward.itemType == itemType and reward.itemId == itemId then
        processor(id, v.name)
        break
      end
    end
  end
end

return this
