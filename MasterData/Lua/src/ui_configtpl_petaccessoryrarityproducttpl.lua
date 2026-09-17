local this = class("petAccessoryRarityProductTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getLaborScore(tpl)
  return tpl.laborScore
end

function this:getRarityAll(tpl)
  return tpl.rarity_all
end

function this:getRarityByScore(score)
  local maxKey = 0
  for id, tpl in pairs(self.data) do
    local laborScore = self:getLaborScore(tpl)
    if laborScore and #laborScore == 2 and score >= laborScore[1] and score <= laborScore[2] then
      local rarity_all = self:getRarityAll(tpl)
      if rarity_all then
        for key, value in pairs(rarity_all) do
          if value ~= 0 and key > maxKey then
            maxKey = key
          end
        end
      end
    end
  end
  return maxKey
end

function this:getMaxRarityDescByLaborScore(score)
  local maxKey = self:getRarityByScore(score)
  local rarityTpl = L_RarityTpl:getTplById(maxKey)
  local color = L_Const.colorHtml[L_RarityTpl:getEquipmentColorAst(L_RarityTpl:getTplById(maxKey))]
  local rarityDescNoColor = L_RarityTpl:getRarityName(rarityTpl)
  local rarityDesc = L_GameUtil.fillColor(rarityDescNoColor, color)
  return rarityDesc or ""
end

function this:getQualityProbByScoreAndRarity(score, rarity)
  for id, tpl in pairs(self.data) do
    local laborScore = self:getLaborScore(tpl)
    if laborScore and #laborScore == 2 and score >= laborScore[1] and score <= laborScore[2] then
      local rarity_all = self:getRarityAll(tpl)
      if rarity_all and rarity_all[rarity] then
        return rarity_all[rarity]
      else
        return 0
      end
    end
  end
  return 0
end

return this
