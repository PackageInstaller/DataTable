local ActMonsterCardPlayData = class("ActMonsterCardPlayData")
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local ActMonsterCardData = require("Game.ActivityFrame.ActivityMonsterCard.ActMonsterCardData")

function ActMonsterCardPlayData:ctor(activityBase)
  self._activityBase = activityBase
  self._actFrameId = activityBase:GetActFrameId()
  self._mainCfg = ConfigData.activity_monster_card[self._actFrameId]
  self._cardDicCfg = ConfigData.activity_monster_card_card[self._actFrameId]
  self._cardDic = {}
  self._cardTypeListDic = {}
  self._selectCardList = {}
end

function ActMonsterCardPlayData:ActMCPD_RefreshCardDatas(cardMsg, isFromDiff)
  self._selectCardList = cardMsg.installed
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for monCardId, cardDataMsg in pairs(cardMsg.cards) do
    local isNewOrUpdate = false
    local cardData = self._cardDic[monCardId]
    if cardData ~= nil then
      isNewOrUpdate = cardData:AacMCD_UpdateNum(cardDataMsg.num)
    else
      self:ActMCPD_AddCardData(cardDataMsg)
      isNewOrUpdate = true
    end
    if isFromDiff and isNewOrUpdate then
      userDataCache:SetCommonMonsterCardIsHasBlue(self._actFrameId, monCardId, true)
    end
  end
end

function ActMonsterCardPlayData:ActMCPD_AddCardData(cardDataMsg)
  local monCardId = cardDataMsg.id
  local monCardData = ActMonsterCardData.New(cardDataMsg, self._cardDicCfg)
  local type = monCardData:AacMCD_GetType()
  local list = self._cardTypeListDic[type]
  if list == nil then
    list = {}
    self._cardTypeListDic[type] = list
  end
  self._cardDic[monCardId] = monCardData
  table.insert(list, monCardData)
end

function ActMonsterCardPlayData:ActMCPD_GetIsSelectedCard(monCardData)
  local monCardId = monCardData:AacMCD_GetId()
  return table.contain(self._selectCardList, monCardId)
end

function ActMonsterCardPlayData:ActMCPD_SelectCard(monCardData)
  local maxNum = self:ActMCPD_GetCardCouldSelectNum()
  if maxNum <= #self._selectCardList then
    return false
  end
  local monCardId = monCardData:AacMCD_GetId()
  table.insert(self._selectCardList, monCardId)
  return true
end

function ActMonsterCardPlayData:ActMCPD_DeselectCard(monCardData)
  local monCardId = monCardData:AacMCD_GetId()
  table.removebyvalue(self._selectCardList, monCardId)
end

function ActMonsterCardPlayData:ActMCPD_DeselectAllCard()
  self._selectCardList = {}
end

function ActMonsterCardPlayData:ActMCPD_GetIsHaveSelectedCard()
  return #self._selectCardList > 0
end

function ActMonsterCardPlayData:ActMCPD_AutoSelectCard(siftingCardFun)
  local list = self:ActMCPD_GetCardDataListByType(eActMonsterCardEnum.cardType.active)
  local cardList = {}
  for _, cardData in pairs(list) do
    if siftingCardFun(cardData) then
      table.insert(cardList, cardData)
    end
  end
  table.sort(cardList, function(a, b)
    local quality_a = a:AacMCD_GetQuailty()
    local quality_b = b:AacMCD_GetQuailty()
    if quality_a ~= quality_b then
      return quality_a > quality_b
    end
    local level_a = a:AacMCD_GetLevel()
    local level_b = b:AacMCD_GetLevel()
    if level_a ~= level_b then
      return level_a > level_b
    end
    return a:AacMCD_GetId() > b:AacMCD_GetId()
  end)
  local maxNum = self:ActMCPD_GetCardCouldSelectNum()
  self:ActMCPD_DeselectAllCard()
  for i = 1, maxNum do
    local cardData = cardList[i]
    if cardData ~= nil then
      self:ActMCPD_SelectCard(cardData)
    else
      return
    end
  end
end

function ActMonsterCardPlayData:ActMCPD_GetCardDataListByType(type)
  return self._cardTypeListDic[type] or table.emptytable
end

function ActMonsterCardPlayData:ActMCPD_GetNotGettedCardDataListByType(type)
  local list = {}
  for monCardId, cfg in pairs(self._cardDicCfg) do
    if cfg.card_type_id == type and self._cardDic[monCardId] == nil then
      local monCardData = ActMonsterCardData.New({id = monCardId, num = 1}, self._cardDicCfg, true)
      table.insert(list, monCardData)
    end
  end
  return list
end

function ActMonsterCardPlayData:ActMCPD_GetAllCardDataListByType(type)
  local list = self:ActMCPD_GetCardDataListByType(type)
  local listNotGetted = self:ActMCPD_GetNotGettedCardDataListByType(type)
  table.insertto(listNotGetted, list)
  table.sort(listNotGetted, function(a, b)
    return a:AacMCD_IsLarger(b)
  end)
  return listNotGetted
end

function ActMonsterCardPlayData:ActMCPD_GetSelectedCardList()
  return self._selectCardList
end

function ActMonsterCardPlayData:ActMCPD_GetSelectedCardDic()
  local dic = {}
  for _, monCardId in ipairs(self._selectCardList) do
    dic[monCardId] = true
  end
  return dic
end

function ActMonsterCardPlayData:ActMCPD_GetSelectedCardDataList()
  local list = self:ActMCPD_GetSelectedCardList()
  local tempList = {}
  for index, monCardId in ipairs(list) do
    tempList[index] = self._cardDic[monCardId]
  end
  return tempList
end

function ActMonsterCardPlayData:ActMCPD_GetCardTypeNum(type)
  return ConfigData.activity_monster_card_card.act2MaxNumDic[self._actFrameId][type]
end

function ActMonsterCardPlayData:ActMCPD_GetCardCouldSelectNum()
  return self._mainCfg.max_equip
end

function ActMonsterCardPlayData:ActMCPD_GetTipId()
  return self._mainCfg.rule_id
end

function ActMonsterCardPlayData:ActMCPD_GetActFrameId()
  return self._actFrameId
end

function ActMonsterCardPlayData:ActMCPD_IsHaveCard(monCardId)
  return self._cardDic[monCardId] ~= nil
end

function ActMonsterCardPlayData:ActMCPD_IsHaveBlue()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for monCardId, monCardData in pairs(self._cardDic) do
    local isHaveBlue = userDataCache:GetCommonMonsterCardIsHasBlue(self._actFrameId, monCardId)
    if isHaveBlue then
      return true
    end
  end
  return false
end

function ActMonsterCardPlayData:ActMCPD_CleanBlueDotWhenEnterUI()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for monCardId, monCardData in pairs(self._cardDic) do
    userDataCache:SetCommonMonsterCardIsHasBlue(self._actFrameId, monCardId, false)
  end
end

return ActMonsterCardPlayData
