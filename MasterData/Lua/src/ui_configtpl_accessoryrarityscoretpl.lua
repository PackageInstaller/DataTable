local this = class("accessoryRarityScoreTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getScoreMin(tpl)
  return tpl.score_min
end

function this:getScoreMax(tpl)
  return tpl.score_max
end

function this:getRarity(tpl)
  return tpl.rarity
end

return this
