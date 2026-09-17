local this = class("soulessenceRankTpl")

function this:init(config)
  self.data = {}
  for i, v in pairs(config) do
    if self.data[v.relatedId] == nil then
      self.data[v.relatedId] = {}
    end
    self.data[v.relatedId][v.rank] = v
  end
end

function this:getTplList()
  return self.data
end

function this:getrelatedId(tpl)
  return tpl.relatedId
end

function this:getId(tpl)
  return tpl.id
end

function this:getRank(tpl)
  return tpl.rank
end

function this:getRankUpCoin(tpl)
  return tpl.rankUpCoin
end

function this:getRankLevelLimit(tpl)
  return tpl.rankLevelLimit
end

function this:getRankUpItem(tpl)
  return tpl.rankUpItem
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getChildren(relatedId)
  return self.data[relatedId]
end

function this:getTplByIdAndRank(relatedId, rank)
  return self.data[relatedId][rank]
end

function this:getRankUpAttributeAll(tpl)
  return tpl.rankUpAttributeAll
end

function this:getRankUpAttribute(tpl)
  return tpl.rankUpAttribute
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getMaxRank(relatedId)
  local childs = self:getChildren(relatedId)
  local rank = 1
  for _, child in pairs(childs) do
    if rank < child.rank then
      rank = child.rank
    end
  end
  return rank
end

return this
