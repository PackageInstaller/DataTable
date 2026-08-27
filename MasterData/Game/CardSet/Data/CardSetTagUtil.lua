local CardSetTagUtil = {}
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

local function GetTagDesPara1(tagCfg, CsCardData)
  local formatStr = LanguageUtil.GetLocaleText(tagCfg.tag_des)
  return string.format(formatStr, tostring(tagCfg.tag_para1))
end

local GetTagDesFuncDic = {
  [CardSetEnum.eCardTag.AddScore] = GetTagDesPara1,
  [CardSetEnum.eCardTag.AddScorePersent] = function(tagCfg, CsCardData)
    local formatStr = LanguageUtil.GetLocaleText(tagCfg.tag_des)
    local value = FormatNum(tagCfg.tag_para1 / 10)
    return string.format(formatStr, tostring(value))
  end,
  [CardSetEnum.eCardTag.ReduceCost] = GetTagDesPara1,
  [CardSetEnum.eCardTag.UseMoreTimes] = function(tagCfg, CsCardData)
    local formatStr = LanguageUtil.GetLocaleText(tagCfg.tag_des)
    local totalNum = tagCfg.tag_para1
    local curNum = totalNum - CsCardData:GetCsCardUsedNum()
    if 1 < curNum then
      return string.format(formatStr, tostring(totalNum), tostring(curNum))
    end
    return nil
  end
}

function CardSetTagUtil.GetCardSetTagDesById(tagId, CsCardData)
  local tagCfg = ConfigData.activity_card_tag[tagId]
  if tagCfg == nil then
    error("Cant get activity_card_tag cfg, id:" .. tostring(tagId))
    return
  end
  local tagType = tagCfg.tag_type
  local func = GetTagDesFuncDic[tagType]
  if func == nil then
    error("unsurpported tag_type:" .. tostring(tagType))
  end
  return func(tagCfg, CsCardData)
end

return CardSetTagUtil
