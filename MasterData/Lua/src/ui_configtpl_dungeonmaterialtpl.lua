local this = class("dungeonMaterialTpl")

function this:init(config)
  self.data = config
  self.modeInfo = {}
  self.dungeonIdLookup = {}
  self.TypeMap = {}
  local typeIdToIndex = {}
  for _, v in pairs(config) do
    if not typeIdToIndex[v.type] then
      typeIdToIndex[v.type] = #self.modeInfo + 1
      table.insert(self.modeInfo, {
        typeId = v.type,
        levelInfos = {}
      })
    end
    table.insert(self.modeInfo[typeIdToIndex[v.type]].levelInfos, v)
    self.dungeonIdLookup[v.dungeonId] = v
    if self.TypeMap[v.type] == nil then
      self.TypeMap[v.type] = {}
    end
    table.insert(self.TypeMap[v.type], {
      id = v.id
    })
  end
  for _, v2 in ipairs(self.modeInfo) do
    table.sort(v2.levelInfos, function(a, b)
      if a.diff == b.diff then
        return a.id < b.id
      end
      return a.diff < b.diff
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
  for _, v2 in pairs(self.TypeMap) do
    table.sort(v2, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:getTypeById(typeId)
  return self.TypeMap[typeId]
end

function this:getTypeId(tpl)
  return tpl.type
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

function this:getShowCondition(tpl)
  return tpl.showCondition
end

function this:getUnlock(tpl)
  return tpl.unlock
end

function this:getDiff(tpl)
  return tpl.diff
end

function this:getRecommendLevel(tpl)
  return tpl.level
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

function this:getChallengeReward(tpl)
  return tpl.challengeReward
end

function this:getPic(tpl)
  return tpl.pic
end

function this:getIconPath(tpl)
  return tpl.iconPath
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getBossIcon(tpl)
  return tpl.bossIcon
end

function this:getMultBack(tpl)
  return tpl.multBack
end

function this:getMultPic(tpl)
  return tpl.multPic
end

function this:getRecruitPic(tpl)
  return tpl.recruitPic
end

function this:enumMaterialsByReward(itemType, itemId, processor)
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
