local this = class("heroRankTpl")

function this:init(config)
  self.data = {}
  for i, v in pairs(config) do
    if self.data[v.heroId] == nil then
      self.data[v.heroId] = {}
    end
    self.data[v.heroId][v.rank] = v
  end
end

function this:getTplById(id, rankLv)
  local list = self.data[id]
  for _, v in pairs(list) do
    if v.rank == rankLv then
      return v
    end
  end
  return nil
end

function this:getMaxTplById(id)
  local tpl
  if self.data[id] == nil then
    return tpl
  end
  local maxRank = 0
  for i, v in pairs(self.data[id]) do
    if maxRank < v.rank then
      maxRank = i
      tpl = v
    end
  end
  return tpl
end

function this:getRankBreakthroughCoin(tpl)
  return tpl.rankBreakthroughCoin
end

function this:getRankLevelLimit(tpl)
  return tpl.rankLevelLimit
end

function this:getRankBreakthroughItem(tpl)
  return tpl.rankBreakthroughItem
end

function this:getSkill(tpl)
  return tpl.skill
end

function this:getHeroId(tpl)
  return tpl.heroId
end

function this:getRank(tpl)
  return tpl.rank
end

function this:getId(tpl)
  return tpl.id
end

function this:getChildren(heroId)
  return self.data[heroId]
end

function this:getAttributeAll(tpl)
  return tpl.attributeAll
end

function this:getSpecialAttributeAll(tpl)
  return tpl.attributeAll2
end

function this:getCondition(tpl)
  return tpl.condition
end

return this
