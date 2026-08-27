local CardSetBonus = class("CardSetBonus")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function CardSetBonus:ResetCsBonus()
  self._bonusDic = table.GetDefaulValueTable(0)
end

function CardSetBonus:AddCsBonus(cardData, isRemove)
  local idList = cardData:GetCardSetTagList()
  for k, tagId in ipairs(idList) do
    local tagCfg = ConfigData.activity_card_tag[tagId]
    if tagCfg == nil then
      error("Cant get activity_card_tag cfg, id:" .. tostring(tagId))
    else
      local tagType = tagCfg.tag_type
      if tagType ~= CardSetEnum.eCardTag.UseMoreTimes then
        self._bonusDic[tagType] = self._bonusDic[tagType] + (isRemove and -1 or 1) * tagCfg.tag_para1
      end
    end
  end
end

function CardSetBonus:RemoveCsBonus(cardData)
  self:AddCsBonus(cardData, true)
end

function CardSetBonus:GetCsBonus(tagType)
  return self._bonusDic[tagType]
end

return CardSetBonus
