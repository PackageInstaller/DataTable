local this = class("dungeonCrisisCrusadeTpl")

function this:init(config)
  self.data = config
  self._diffData = {}
  for i, v in pairs(config) do
    self._diffData[v.difficulty] = self._diffData[v.difficulty] or {}
    table.insert(self._diffData[v.difficulty], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getData()
  return self.data
end

function this:getLevelIdByDungeonId(dungeonId)
  for i, v in pairs(self.data) do
    if v.dungeonId == dungeonId then
      return v.id
    end
  end
  return 0
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getEntrustType(tpl)
  return tpl.difftype
end

function this:getDifficulty(tpl)
  return tpl.difficulty
end

function this:getRecLevelText(tpl)
  return tpl.recommendedlevel
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

function this:getMainRewardShow(tpl)
  if not tpl.mainReward then
    return nil
  end
  return L_DataUtil.parseRewardConfigNoNum(tpl.mainReward)
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

function this:getConsumeType(tpl)
  return tpl.stamina[1]
end

function this:getConsumeNum(tpl)
  return tpl.stamina[2]
end

function this:getTplListByDiffTag(diff)
  return self._diffData[diff] or {}
end

function this:getContributionValue(tpl)
  return tpl.contributionvalue
end

function this:getPerCompleteTime(tpl)
  return tpl.percompletetime
end

return this
