local this = class("talentRankTpl")

function this:init(config)
  self.data = config
  self.heroRankDic = {}
  for _, v in pairs(config) do
    if not self.heroRankDic[v.heroId] then
      self.heroRankDic[v.heroId] = {}
    end
    self.heroRankDic[v.heroId][v.rank] = v
  end
end

function this:getHeroRankTpls(configId)
  return self.heroRankDic[configId]
end

function this:getHeroRankTpl(configId, rank)
  if not self.heroRankDic[configId] then
    errorf("talent_rank没有英雄id: " .. configId, 2)
    return nil
  end
  return self.heroRankDic[configId][rank]
end

function this:getMaxTpl(configId)
  if not self.heroRankDic[configId] then
    errorf("talent_rank没有英雄id: " .. configId, 2)
    return nil
  end
  local tpl
  local maxRank = 0
  for i, v in pairs(self.heroRankDic[configId]) do
    if maxRank < v.rank then
      maxRank = i
      tpl = v
    end
  end
  return tpl
end

function this:getHeroMaxRankNum(configId)
  if not self.heroRankDic[configId] then
    errorf("talent_rank没有英雄id: " .. configId, 2)
    return 0
  end
  local tpl = self:getMaxTpl(configId)
  return self:getRank(tpl)
end

function this:getMaxVisibleTpl(configId)
  if not self.heroRankDic[configId] then
    errorf("talent_rank没有英雄id: " .. configId, 2)
    return nil
  end
  local tpl
  local maxRank = 0
  for i, v in pairs(self.heroRankDic[configId]) do
    if maxRank < v.rank and v.isVisible then
      maxRank = i
      tpl = v
    end
  end
  tpl = tpl or self:getMaxTpl(configId)
  return tpl
end

function this:getHeroMaxVisibleRankNum(configId)
  if not self.heroRankDic[configId] then
    errorf("talent_rank没有英雄id: " .. configId, 2)
    return 0
  end
  local tpl = self:getMaxVisibleTpl(configId)
  return self:getRank(tpl)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAttribute(tpl)
  return tpl.attribute
end

function this:getId(tpl)
  return tpl.id
end

function this:getHeroId(tpl)
  return tpl.heroId
end

function this:getRankLevelLimit(tpl)
  return tpl.rankLevelLimit
end

function this:getRankBreakthroughCoin(tpl)
  return tpl.rankBreakthroughCoin
end

function this:getRank(tpl)
  return tpl.rank
end

function this:getRankBreakthroughItem(tpl)
  return tpl.rankBreakthroughItem
end

function this:getCondition(tpl)
  return tpl.condition
end

return this
