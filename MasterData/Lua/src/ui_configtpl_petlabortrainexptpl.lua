local this = class("petLaborTrainExpTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getScoreRange(tpl)
  return tpl.score_range
end

function this:getRarityExp(tpl)
  return tpl.rarity_exp
end

function this:getExpByScoreAndRarity(score, rarity)
  for _, tpl in pairs(self.data) do
    local scoreRange = self:getScoreRange(tpl)
    if scoreRange and #scoreRange == 2 then
      local minScore = scoreRange[1]
      local maxScore = scoreRange[2]
      if score >= minScore and score <= maxScore then
        local rarityExp = self:getRarityExp(tpl)
        if rarityExp and rarityExp[rarity] then
          return rarityExp[rarity]
        end
      end
    end
  end
  return 0
end

return this
