local this = class("petLaborAccessoryExtraTpl")

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
  local targetTpl
  for id, tpl in pairs(self.data) do
    local laborScore = self:getLaborScore(tpl)
    if laborScore and #laborScore == 2 and score >= laborScore[1] and score <= laborScore[2] then
      targetTpl = tpl
      break
    end
  end
  if not targetTpl then
    return 0
  end
  local rarity_all = self:getRarityAll(targetTpl)
  if not rarity_all then
    return 0
  end
  local descList = {}
  for rarityKey, rateValue in pairs(rarity_all) do
    if rateValue ~= 0 then
      return rarityKey
    end
  end
  return 0
end

function this:getGoldRarityDescByLaborScore(score, canMakeDesc)
  local singleDesc = L_WordsTpl:getValue("accessory_extra_rate_text")
  local targetTpl
  for id, tpl in pairs(self.data) do
    local laborScore = self:getLaborScore(tpl)
    if laborScore and #laborScore == 2 and score >= laborScore[1] and score <= laborScore[2] then
      targetTpl = tpl
      break
    end
  end
  if not targetTpl then
    return ""
  end
  local rarity_all = self:getRarityAll(targetTpl)
  if not rarity_all then
    return ""
  end
  local rateDescTpl = L_GameTpl:getPetLaborAccessoryExtraRateDescTpl()
  local descList = {}
  for rarityKey, rateValue in pairs(rarity_all) do
    if rateValue ~= 0 then
      local rarityTpl = L_RarityTpl:getTplById(rarityKey)
      local color = L_Const.colorHtml[L_RarityTpl:getEquipmentColorAst(L_RarityTpl:getTplById(rarityKey))]
      local rarityDescNoColor = L_RarityTpl:getRarityName(rarityTpl)
      local rarityDesc = L_GameUtil.fillColor(rarityDescNoColor, color)
      local rateDesc = ""
      for rateId, rateTpl in pairs(rateDescTpl.data) do
        local rate = rateDescTpl:getRate(rateTpl)
        if rate and #rate == 2 and rateValue >= rate[1] and rateValue <= rate[2] then
          rateDesc = rateDescTpl:getRateDesc(rateTpl) or ""
          break
        end
      end
      local desc = L_Lang:get(singleDesc, {
        [0] = rarityDesc,
        [1] = canMakeDesc,
        [2] = rateDesc
      })
      table.insert(descList, desc)
    end
  end
  return table.concat(descList, "\n")
end

return this
