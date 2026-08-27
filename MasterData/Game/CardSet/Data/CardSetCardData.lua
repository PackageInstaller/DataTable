local CardSetCardData = class("CardSetCardData")
local CS_GameData_Ins = CS.GameData.instance
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local CardSetTagUtil = require("Game.CardSet.Data.CardSetTagUtil")

function CardSetCardData.CreateCardDataByIdAndData(actId, cardId, uid, cardElem)
  local actCardSetCfg = ConfigData.activity_card_card[actId]
  if actCardSetCfg == nil then
    error("can't get actCardSetCfg with actId:" .. tostring(actId))
    return nil
  end
  local cardCfg = actCardSetCfg[cardId]
  if cardCfg == nil then
    error("can't get actCardSetCfg with cardId:" .. tostring(cardId))
    return nil
  end
  local data = CardSetCardData.New()
  data.__cardCfgDic = cardCfg
  for i = 0, CardSetEnum.eCardTive.max - 1 do
    if cardCfg[i] ~= nil then
      data.__cardEffectId = i
    end
  end
  data.__actId = actId
  data.__cardCfg = cardCfg[data.__cardEffectId]
  data.__uid = uid
  data:_SetCardMsg(cardElem)
  return data
end

function CardSetCardData.Clone(otherCardData)
  local data = CardSetCardData.New()
  data.__cardCfgDic = otherCardData.__cardCfgDic
  data.__cardCfg = otherCardData.__cardCfg
  data.__cardEffectId = otherCardData.__cardEffectId
  data.__uid = otherCardData.__uid
  return data
end

function CardSetCardData:ctor()
  self.__cardCfgDic = nil
  self.__cardCfg = nil
  self.__cardEffectId = nil
  self.__uid = nil
end

function CardSetCardData:_SetCardMsg(cardElem)
  if cardElem == nil then
    return
  end
  self._tagIds = cardElem.tagIds
  self._tagEffectType = cardElem.tagEffectType
  self._useCount = cardElem.useCount
end

function CardSetCardData:GetCardSetCardUid()
  return self.__uid
end

function CardSetCardData:GetCardSetCardId()
  return self.__cardCfg.card_id
end

function CardSetCardData:GetCardCurTypeCfg()
  return self.__cardCfg
end

function CardSetCardData:_GetCardEffectCfg(effectId)
  if effectId == nil then
    return self.__cardCfg
  end
  local cardCfg = self.__cardCfgDic[effectId]
  if cardCfg == nil then
    error("Cant get cardCfg, effectId:" .. tostring(effectId))
  end
  return cardCfg
end

function CardSetCardData:GetCardSetCardType(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  return cardCfg.card_type
end

function CardSetCardData:GetCardSetCardTypeName()
  local cardTypeCfg = ConfigData.activity_card_card_type[self.__actId]
  local typeId = self:GetCardSetCardType()
  local cfg = cardTypeCfg[typeId]
  if cfg == nil then
    error("Cat get activity_card_card_type cfg, actId:%s, typeId:%s", self.__actId, typeId)
    return
  end
  return LanguageUtil.GetLocaleText(cfg.type_name)
end

function CardSetCardData:GetCardSetCardName(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  local orgDes = LanguageUtil.GetLocaleText(cardCfg.card_name)
  if not string.IsNullOrEmpty(orgDes) then
    return orgDes
  end
  if cardCfg.name_describe_read == 1 then
    local cardId = self:GetCardSetCardId()
    local itemCfg = ConfigData.item[cardId]
    if itemCfg ~= nil then
      return LanguageUtil.GetLocaleText(itemCfg.name)
    end
  elseif cardCfg.name_describe_read == 2 then
    local skillId = self:__GetSkillId(cardCfg)
    local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(skillId)
    if skillCfg == nil then
      error("找不到技能配置:" .. tostring(skillId))
    else
      return skillCfg.Name
    end
  end
  return ""
end

function CardSetCardData:GetCardSetCardDes(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  local orgDes = LanguageUtil.GetLocaleText(cardCfg.card_describe)
  local des
  if not string.IsNullOrEmpty(orgDes) then
    des = orgDes
  elseif cardCfg.name_describe_read == 1 then
    local cardId = self:GetCardSetCardId()
    local itemCfg = ConfigData.item[cardId]
    if itemCfg ~= nil then
      des = LanguageUtil.GetLocaleText(itemCfg.describe)
    end
  elseif cardCfg.name_describe_read == 2 then
    local skillId = self:__GetSkillId(cardCfg)
    local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(skillId)
    if skillCfg == nil then
      error("找不到技能配置:" .. tostring(skillId))
      return
    else
      local lv = 1
      local unAdv = false
      des = skillCfg:GetLevelDescribe(lv, unAdv, true)
    end
  end
  local tagDes = self:GetCardSetTagDes(effectId)
  if string.IsNullOrEmpty(tagDes) then
    return des
  end
  return des .. "\n" .. tagDes
end

function CardSetCardData:__GetSkillId(cardCfg)
  local dungeonBuffId = cardCfg.protocol_id
  local buffId
  local dbCfg = ConfigData.dungeon_buff[dungeonBuffId]
  if dbCfg ~= nil then
    buffId = dbCfg.buff_id
  end
  if buffId ~= nil then
    local chipCfg = ConfigData.chip[buffId]
    if chipCfg ~= nil then
      return chipCfg.buff_id
    end
  end
  return -1
end

function CardSetCardData:GetCardSetCardTive(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  return cardCfg.effect_type
end

function CardSetCardData:GetCardSetCardIcon(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  return cardCfg.card_icon
end

function CardSetCardData:GetCardSetCardCoinAddNum(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  return cardCfg.reward_value
end

function CardSetCardData:GetCardSetCardScoreAddNum(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  return cardCfg.score_value
end

function CardSetCardData:GetCardSetCardPowAddRate(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  return cardCfg.combat_correct
end

function CardSetCardData:GetCardSetCardIsNew()
end

function CardSetCardData:GetCardSetCardIsNotComplete()
end

function CardSetCardData:GetIsCardSwitchable()
  return table.count(self.__cardCfgDic) > 1
end

function CardSetCardData:GetCardCfgDic()
  return self.__cardCfgDic
end

function CardSetCardData:SetCardEffectId(cardEffectId)
  if self.__cardCfgDic[cardEffectId] == nil then
    error("card not has diff type:" .. tostring(cardEffectId))
    return
  end
  self.__cardEffectId = cardEffectId
  self.__cardCfg = self.__cardCfgDic[cardEffectId]
end

function CardSetCardData:GetCardEffectId()
  return self.__cardEffectId
end

function CardSetCardData:GetCardStQualityColor(effectId)
  local cardCfg = self:_GetCardEffectCfg(effectId)
  local cfg = ConfigData.activity_card_quality[cardCfg.quality_id]
  if cfg == nil or #cfg.color_num ~= 3 then
    error("activity_card_quality.color_num error, quality_id:" .. tostring(cardCfg.quality_id))
    return nil
  end
  return Color.Temp(cfg.color_num[1] / 255, cfg.color_num[2] / 255, cfg.color_num[3] / 255)
end

function CardSetCardData:GetCardStRankBanId()
  return self.__cardCfg.rankBanId
end

function CardSetCardData:GetCardSetTagDes(effectId)
  local str = ""
  local idList = self:GetCardSetTagList(effectId)
  for k, tagId in ipairs(idList) do
    local des = CardSetTagUtil.GetCardSetTagDesById(tagId, self)
    if not string.IsNullOrEmpty(des) then
      if string.IsNullOrEmpty(str) then
        str = des
      else
        str = str .. "\n" .. des
      end
    end
  end
  return str
end

function CardSetCardData:GetCardSetTagList(effectId)
  if self._tagEffectType == nil then
    return table.emptytable
  end
  if #self._tagEffectType == 0 then
    return self._tagIds[1] ~= nil and self._tagIds[1].data or table.emptytable
  end
  effectId = effectId or self:GetCardEffectId()
  for k, eId in ipairs(self._tagEffectType) do
    if eId == effectId then
      return self._tagIds[k] ~= nil and self._tagIds[k].data or table.emptytable
    end
  end
  return table.emptytable
end

function CardSetCardData:GetCardSetTagCfgFirst(effectId)
  local tagIdList = self:GetCardSetTagList(effectId)
  if #tagIdList == 0 then
    return nil
  end
  local tagId = tagIdList[1]
  local tagCfg = ConfigData.activity_card_tag[tagId]
  if tagCfg == nil then
    error("Cant get activity_card_tag cfg, id:" .. tostring(tagId))
  end
  return tagCfg
end

function CardSetCardData:GetCardSetTagAddScoreNum(effectId)
  local scoreAdd = 0
  local tagIdList = self:GetCardSetTagList(effectId)
  for k, tagId in ipairs(tagIdList) do
    local tagCfg = ConfigData.activity_card_tag[tagId]
    if tagCfg == nil then
      error("Cant get activity_card_tag cfg, id:" .. tostring(tagId))
    else
      local tagType = tagCfg.tag_type
      if tagType == CardSetEnum.eCardTag.AddScore then
        scoreAdd = scoreAdd + tagCfg.tag_para1
      end
    end
  end
  return scoreAdd
end

function CardSetCardData:GetCsCardUsedNum()
  return self._useCount or 0
end

return CardSetCardData
