local CardSetUtil = {}

function CardSetUtil.GetCardSetDiffName(rankId, diffId)
  local actId = ConfigData.activity_card_main.cardRankId2ActIdMap[rankId]
  local diffStr
  if ConfigData.activity_card_diff[actId] and ConfigData.activity_card_diff[actId][diffId] then
    local diffCfg = ConfigData.activity_card_diff[actId][diffId]
    diffStr = LanguageUtil.GetLocaleText(diffCfg.difficulty_name)
  else
    error(string.format("cant get activity_card_diff, rankId:%s, actId:%s, diffId:%s", rankId, actId, diffId))
  end
  return diffStr
end

return CardSetUtil
