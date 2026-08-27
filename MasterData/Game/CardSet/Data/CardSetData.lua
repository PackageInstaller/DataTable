local CardSetData = class("CardSetData")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local CardSetCardData = require("Game.CardSet.Data.CardSetCardData")
local CarSetDiffData = require("Game.CardSet.Data.CarSetDiffData")
local CardSetBonus = require("Game.CardSet.Data.Bonus.CardSetBonus")
local CardSetRankRoundData = require("Game.CardSet.Data.Round.CardSetRankRoundData")
local cs_MessageCommon = CS.MessageCommon

function CardSetData.CreatCardDataSetByAct(actCardSetData, cat)
  local actId = actCardSetData:GetActId()
  local data = CardSetData.New()
  data.__cardSetActData = actCardSetData
  data.__cardTypeCfgDic = ConfigData.activity_card_card_type[actId]
  data.__playType = cat
  local isRankMode = cat == CardSetEnum.eSetType.rank
  local diffList = isRankMode and actCardSetData:GetCardSetRankModeDiffList() or actCardSetData:GetCardSetNormalModeDiffList()
  local lastRankRoundId = actCardSetData:GetActCsRankLastRoundId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local savedDiff = saveUserData:GetCardSetLastDiffId(actId, data.__playType, lastRankRoundId)
  data.__diffDataList = {}
  for index, diffId in ipairs(diffList) do
    local diffData = CarSetDiffData.CreateDiffData(actId, diffId)
    table.insert(data.__diffDataList, diffData)
    local challengeDiffData = diffData:GetCardSetDiffChallengeData()
    local challengeDiffId = challengeDiffData and challengeDiffData:GetCardSetDiffDiffId() or -1
    if index == 1 then
      data:SetCardSetCurDiffId(diffId)
    end
    if diffId == savedDiff or challengeDiffId == savedDiff then
      data:SetCardSetCurDiffId(savedDiff)
    end
  end
  if isRankMode then
    data._rankRoundDataList = {}
    local rankRoundList = ConfigData.activity_card_rank_round[actId]
    if rankRoundList == nil then
      error("Cant get activity_card_rank_round cfg, actId:" .. tostring(actId))
    end
    for k, rankRoundCfg in ipairs(rankRoundList) do
      local rankRoundData = CardSetRankRoundData.New(rankRoundCfg)
      table.insert(data._rankRoundDataList, rankRoundData)
    end
  end
  data:RefreshCardSetData(cat)
  return data
end

function CardSetData:ctor()
  self.__cardDeckListDic = nil
  self.__cardTypeCfgDic = nil
  self.__diffDataList = nil
  self.__selectedCardListDic = nil
  self.__selectedCardUidDic = nil
  self.__curDiffId = nil
  self.__playType = nil
  self.__lockedInfo = nil
  self.__curRound = nil
  self.__battlePoint = nil
  self.__curRoundData = nil
  self.__historyRoundDataList = nil
end

function CardSetData:ResetCardSetSelected()
  self.__selectedCardListDic = {}
  self.__selectedCardUidDic = {}
  if self._bonus == nil then
    self._bonus = CardSetBonus.New()
  end
  self._bonus:ResetCsBonus()
end

function CardSetData:RefreshCardSetData(cat)
  if cat == CardSetEnum.eSetType.rank then
    self:_UpdRankRound()
    local lastRankRoundId = self.__cardSetActData:GetActCsRankLastRoundId()
    self:SetCsRankRoundId(lastRankRoundId)
    return
  end
  local storageMsg = self.__cardSetActData:GetCdStDataByCat(cat)
  self:_UpdRound(storageMsg)
end

function CardSetData:_UpdRound(storageMsg)
  local cat = self.__playType
  self.__cardDeckListDic = {}
  self:ResetCardSetSelected()
  local actId = self.__cardSetActData:GetActId()
  local actFrameId = self.__cardSetActData:GetActFrameId()
  
  local function AddCardData(cardData, selectedElem)
    local cardType = cardData:GetCardSetCardType()
    if self.__cardDeckListDic[cardType] == nil then
      self.__cardDeckListDic[cardType] = {}
    end
    table.insert(self.__cardDeckListDic[cardType], cardData)
    if selectedElem then
      if selectedElem.selected then
        self:SetSelectCard(cardData, true)
      end
      if selectedElem.effectId > 0 then
        cardData:SetCardEffectId(selectedElem.effectId)
      end
    end
  end
  
  local isRankMode = cat == CardSetEnum.eSetType.rank
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local roundId = storageMsg and storageMsg.round or 1
  local lastSelectedInfo = saveUserData:GetCardSetLastSelectedCardInfo(actId, cat, roundId)
  local lastSelectedDic = lastSelectedInfo and lastSelectedInfo.data or table.emptytable
  if isRankMode then
    local diffId = saveUserData:GetCardSetLastDiffId(actId, cat, roundId)
    if diffId then
      self:SetCardSetCurDiffId(diffId)
    end
  end
  if storageMsg then
    if self.__curRound ~= nil and self.__curRound ~= storageMsg.round then
      local curDiffData = self:GetCardSetCurDiffData()
      local challengeDiffData = curDiffData:GetCardSetDiffChallengeData()
      if challengeDiffData ~= nil then
        local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
        local lastDiffPassTimesDic = saveUserData:GetCardSetLastDiffPassTimesDic(actId)
        local challengeDiffId = challengeDiffData:GetCardSetDiffDiffId()
        if 0 < (lastDiffPassTimesDic[challengeDiffId] or 0) and challengeDiffData:GetIsCardSetDiffUnlock() then
          self:SetCardSetCurDiffId(challengeDiffId)
        end
      end
    end
    self.__lockedInfo = storageMsg.locked
    self.__curRound = storageMsg.round
    self.__battlePoint = storageMsg.point
    self.__curRoundBattleNum = storageMsg.dungeonStep
    self.__curRoundData = storageMsg.curRoundData
    if not isRankMode and lastSelectedInfo and (self.__curRound ~= lastSelectedInfo.roundId or self.__curRoundBattleNum ~= lastSelectedInfo.battleNum) then
      lastSelectedDic = table.emptytable
    end
    for uid, cardElem in pairs(storageMsg.cards) do
      local cardId = cardElem.cardId
      local cardData = CardSetCardData.CreateCardDataByIdAndData(actId, cardId, uid, cardElem)
      if cardData ~= nil then
        AddCardData(cardData, lastSelectedDic[uid])
      end
    end
  else
    self.__curRound = 0
  end
  self:SortAllCardList()
  for index, diffData in ipairs(self.__diffDataList) do
    local diffId = diffData:GetCardSetDiffDiffId()
    if self.__curDiffId == diffId then
      break
    end
    local challengeDiffData = diffData:GetCardSetDiffChallengeData()
    if challengeDiffData and self.__curDiffId == challengeDiffData:GetCardSetDiffDiffId() then
      local challengeDiffId = challengeDiffData:GetCardSetDiffDiffId()
      local passChanllengeTimes = self.__cardSetActData:GetActCardSetPassDiffTimes(cat, challengeDiffId)
      if 0 < passChanllengeTimes then
        self:SetCardSetCurDiffId(diffId)
      end
    end
  end
  self:CheckCardSetDiffBan()
end

function CardSetData:SortAllCardList()
  local function sortFunc(a, b)
    local order_a = a:GetCardSetCardUid()
    
    local order_b = b:GetCardSetCardUid()
    return order_a < order_b
  end
  
  for cardType, cardList in pairs(self.__cardDeckListDic) do
    table.sort(cardList, sortFunc)
  end
end

function CardSetData:GetCardSetCardList4Type(cardType, withoutHide)
  if self.__cardDeckListDic[cardType] == nil then
    return table.emptytable
  end
  local cardList = self.__cardDeckListDic[cardType]
  if withoutHide then
    local diffData = self:GetCardSetCurDiffData()
    local hideCardIdDic = diffData:GetCardSetDiffHideCardIdDic()
    if table.IsEmptyTable(hideCardIdDic) then
      return cardList
    end
    local newCardList = {}
    for k, v in ipairs(cardList) do
      if hideCardIdDic[v:GetCardSetCardId()] == nil then
        table.insert(newCardList, v)
      end
    end
    return newCardList
  end
  return cardList
end

function CardSetData:GetCardSetCardEffectTotalNumDic()
  local dic = table.GetDefaulValueTable(0)
  local cardList = self:GetCardSetCardList4Type(CardSetEnum.eCardType.Buff)
  for k, cardData in ipairs(cardList) do
    local cfgDic = cardData:GetCardCfgDic()
    for effectId, cfg in pairs(cfgDic) do
      dic[effectId] = dic[effectId] + 1
    end
  end
  return dic
end

function CardSetData:GetCardSetCardEffectSelectedlNumDic()
  local dic = table.GetDefaulValueTable(0)
  local selectedCardDataList = self:GetSelectedCardListByType(CardSetEnum.eCardType.Buff)
  for k, cardData in ipairs(selectedCardDataList) do
    local effectId = cardData:GetCardEffectId()
    dic[effectId] = dic[effectId] + 1
  end
  return dic
end

function CardSetData:GetSelectedCardListDic()
  return self.__selectedCardListDic
end

function CardSetData:GetCardSetCardHoldLimitNum4Type(cardType)
  local typeCfg = self.__cardTypeCfgDic[cardType]
  return typeCfg.use_limit
end

function CardSetData:GetCardSetCardUseLeast4Type(cardType)
  local typeCfg = self.__cardTypeCfgDic[cardType]
  local isRankMode = self.__playType == CardSetEnum.eSetType.rank
  if isRankMode and typeCfg.rank_use_least ~= nil then
    return typeCfg.rank_use_least
  end
  return typeCfg.use_least
end

function CardSetData:GetCardSetCardHUseLimitNum4Type(cardType)
  local typeCfg = self.__cardTypeCfgDic[cardType]
  local isRankMode = self.__playType == CardSetEnum.eSetType.rank
  if isRankMode and typeCfg.rank_use_limit ~= nil then
    return typeCfg.rank_use_limit
  end
  return typeCfg.use_limit
end

function CardSetData:GetCardSetCardHName4Type(cardType)
  local typeCfg = self.__cardTypeCfgDic[cardType]
  return LanguageUtil.GetLocaleText(typeCfg.type_name)
end

function CardSetData:GetCardSetCardNum4Type(cardType)
  if self.__cardDeckListDic[cardType] == nil then
    return 0
  end
  return #self.__cardDeckListDic[cardType]
end

function CardSetData:GetCardSetSelectCardNum4Type(cardType)
  if self.__selectedCardListDic[cardType] == nil then
    return 0
  end
  return #self.__selectedCardListDic[cardType]
end

function CardSetData:SetSelectCard(cardData, bool)
  local cardType = cardData:GetCardSetCardType()
  local selectedList = self.__selectedCardListDic[cardType]
  if selectedList == nil then
    selectedList = {}
    self.__selectedCardListDic[cardType] = selectedList
  end
  if bool then
    table.insert(selectedList, cardData)
    self.__selectedCardUidDic[cardData:GetCardSetCardUid()] = cardData
    self._bonus:AddCsBonus(cardData)
  else
    self.__selectedCardUidDic[cardData:GetCardSetCardUid()] = nil
    self._bonus:RemoveCsBonus(cardData)
    for index, s_cardData in pairs(selectedList) do
      if s_cardData == cardData then
        table.remove(selectedList, index)
        return
      end
    end
  end
end

function CardSetData:GetIsSelectedCard(cardData)
  return self.__selectedCardUidDic[cardData:GetCardSetCardUid()] ~= nil
end

function CardSetData:GetSelectedCardListByType(cardType)
  if self.__selectedCardListDic[cardType] == nil then
    return table.emptytable
  end
  return self.__selectedCardListDic[cardType]
end

function CardSetData:GetCardSetDiffDataList()
  return self.__diffDataList
end

function CardSetData:IsExistCardSetDiffChanllenge()
  for k, diffData in ipairs(self.__diffDataList) do
    if diffData:GetCardSetDiffChallengeData() ~= nil then
      return true
    end
  end
  return false
end

function CardSetData:SetCardSetCurDiffId(diffId)
  self.__curDiffId = diffId
end

function CardSetData:CheckCardSetDiffBan()
  local diffData = self:GetCardSetCurDiffData()
  local banEffectDic = diffData:GetCardSetDiffBanEffectDic()
  local banCardIdDic = diffData:GetCardSetDiffBanCardIdDic()
  local hideCardIdDic = diffData:GetCardSetDiffHideCardIdDic()
  for cardType, cardDataList in pairs(self.__selectedCardListDic) do
    for i = #cardDataList, 1, -1 do
      local cardData = cardDataList[i]
      local cardId = cardData:GetCardSetCardId()
      if banEffectDic[cardData:GetCardEffectId()] ~= nil or banCardIdDic[cardId] ~= nil or hideCardIdDic[cardId] ~= nil then
        self:SetSelectCard(cardData, false)
        MsgCenter:Broadcast(eMsgEventId.OnCardSetCardChange, cardData, false)
      end
    end
  end
end

function CardSetData:GetCardSetCurDiffId()
  return self.__curDiffId
end

function CardSetData:GetCardSetCurDiffData()
  for index, diffData in ipairs(self.__diffDataList) do
    if self.__curDiffId == diffData:GetCardSetDiffDiffId() then
      return diffData
    end
    local challengeDiffData = diffData:GetCardSetDiffChallengeData()
    if challengeDiffData and self.__curDiffId == challengeDiffData:GetCardSetDiffDiffId() then
      return challengeDiffData
    end
  end
  error("cant get diffData, diffId:" .. tostring(self.__curDiffId))
  return nil
end

function CardSetData:GetCardSetCurPlayType()
  return self.__playType
end

function CardSetData:GetCardSetCurRound()
  return self.__curRound
end

function CardSetData:GetCardSetCurBattleNum()
  return self.__curRoundBattleNum
end

function CardSetData:GenCardSetNum()
  local selectedCardListDic = self:GetSelectedCardListDic()
  local battlePowAdd = 0
  local otherAdd = 0
  if self.__playType == CardSetEnum.eSetType.normal or self.__playType == CardSetEnum.eSetType.rewind then
    for cardType, cardDataList in pairs(selectedCardListDic) do
      for _, cardData in pairs(cardDataList) do
        otherAdd = otherAdd + cardData:GetCardSetCardCoinAddNum()
        battlePowAdd = battlePowAdd + cardData:GetCardSetCardPowAddRate()
      end
    end
  elseif self.__playType == CardSetEnum.eSetType.rank then
    for cardType, cardDataList in pairs(selectedCardListDic) do
      for _, cardData in pairs(cardDataList) do
        otherAdd = otherAdd + cardData:GetCardSetCardScoreAddNum()
        battlePowAdd = battlePowAdd + cardData:GetCardSetCardPowAddRate()
      end
    end
  end
  local diffData = self:GetCardSetCurDiffData()
  local baseValue = 0
  local addReate = 0
  if self.__playType == CardSetEnum.eSetType.normal or self.__playType == CardSetEnum.eSetType.rewind then
    baseValue = diffData:GetCardSetBaseReward()
    addReate = diffData:GetCardSetRewardCoe()
  elseif self.__playType == CardSetEnum.eSetType.rank then
    baseValue = diffData:GetCardSetBaseScore()
    addReate = diffData:GetCardSetScoreCoe()
  end
  local basePow = diffData:GetCardSetBasePow()
  local powRate = diffData:GetCardSetPowCoe()
  otherAdd = otherAdd + self._bonus:GetCsBonus(CardSetEnum.eCardTag.AddScore)
  local point = math.floor(baseValue + otherAdd * addReate / 1000)
  point = point + math.floor(point * self._bonus:GetCsBonus(CardSetEnum.eCardTag.AddScorePersent) / 1000)
  local recommendPow = math.ceil(basePow + battlePowAdd * powRate / 1000)
  return addReate, point, recommendPow
end

function CardSetData:GenCardSetRankScoreAdd(battleFrame)
  local actId = self.__cardSetActData:GetActId()
  local scoreCfg = ConfigData.activity_card_time_score[actId]
  if scoreCfg == nil then
    error("Cant get activity_card_time_score cfg, id:" .. tostring(actId))
    return 0
  end
  local diffData = self:GetCardSetCurDiffData()
  local coe = diffData:GetCardSetScoreCoe()
  local scoreAdd = coe / 1000 * (scoreCfg.dividend / (scoreCfg.basic_divisor + battleFrame))
  return math.ceil(scoreAdd)
end

function CardSetData:GetCardSetRankId()
  return self.__cardSetActData:GetActCardSetRankId()
end

function CardSetData:GetActCardSetData()
  return self.__cardSetActData
end

function CardSetData:GetCardSetBannedHeroTeaNum()
  if self.__playType == CardSetEnum.eSetType.rank then
    return self:GetCardSetRankBannedHeroTeaNum()
  end
  if self.__lockedInfo == nil then
    return 0
  else
    return #self.__lockedInfo.forms
  end
end

function CardSetData:GetCardSetBannedHeroDic()
  local heroIdDic = {}
  if self.__playType == CardSetEnum.eSetType.rank then
    return self:_GetRankModeBanedHeroDic(heroIdDic)
  end
  return self:_GetBanHeroDic(self.__lockedInfo, heroIdDic)
end

function CardSetData:_GetBanHeroDic(lockedInfo, heroIdDic)
  if lockedInfo == nil then
    return heroIdDic
  end
  for _, formMsg in pairs(lockedInfo.forms) do
    for _, heroId in pairs(formMsg.heroIds) do
      heroIdDic[heroId] = true
    end
  end
  for _, heroId in pairs(lockedInfo.officeHeroIds) do
    heroIdDic[heroId] = true
  end
  return heroIdDic
end

function CardSetData:_GetRankModeBanedHeroDic(heroIdDic)
  for k, v in ipairs(self._rankRoundDataList) do
    if k ~= self._curRankRoundId then
      local lockInfo = v:GetCsRankRoundLocked()
      self:_GetBanHeroDic(lockInfo, heroIdDic)
    end
  end
  return heroIdDic
end

function CardSetData:GetCardSetBannedFairyDic()
  local fairyUidDic = {}
  if self.__playType == CardSetEnum.eSetType.rank then
    return self:_GetRankModeBannedFairyDic(fairyUidDic)
  end
  return self:_GetBannedFairyDic(self.__lockedInfo, fairyUidDic)
end

function CardSetData:_GetBannedFairyDic(lockedInfo, fairyUidDic)
  if lockedInfo == nil then
    return fairyUidDic
  end
  for _, formMsg in pairs(lockedInfo.forms) do
    fairyUidDic[formMsg.fairyUid] = true
  end
  return fairyUidDic
end

function CardSetData:_GetRankModeBannedFairyDic(fairyUidDic)
  for k, v in ipairs(self._rankRoundDataList) do
    if k ~= self._curRankRoundId then
      local lockInfo = v:GetCsRankRoundLocked()
      self:_GetBannedFairyDic(lockInfo, fairyUidDic)
    end
  end
  return fairyUidDic
end

function CardSetData:GetCardSetBannedTeamData()
  if self.__lockedInfo == nil then
    return nil
  end
  return self.__lockedInfo.forms
end

function CardSetData:GetCardSetBattlePoint()
  return self.__battlePoint
end

function CardSetData:GetCardSetRoundResource()
  return self.__curRoundData and self.__curRoundData.rewardScore or 0
end

function CardSetData:SaveCardSetSelectedInfo()
  local selectedCardDic = {}
  for cardType, cardList in pairs(self.__cardDeckListDic) do
    for k, cardData in ipairs(cardList) do
      selectedCardDic[cardData:GetCardSetCardUid()] = {
        selected = self:GetIsSelectedCard(cardData),
        effectId = cardData:GetCardEffectId()
      }
    end
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self.__cardSetActData:GetActId()
  local infoTab = {
    data = selectedCardDic,
    difficultyId = self.__curDiffId,
    roundId = self:GetCardSetCurRound(),
    battleNum = self:GetCardSetCurBattleNum()
  }
  saveUserData:SetCardSetLastSelectedCardInfo(actId, self.__playType, infoTab)
end

function CardSetData:GetCurCardSetScoreItemCfg()
  local itemId = self.__cardSetActData:GetCardSetScoreItemIdByType(self.__playType)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("cant get itemCfg, itemId:" .. tostring(itemId))
    return
  end
  return itemCfg
end

function CardSetData:IsCurCardSetDiffFriendSupportOpen()
  local diffData = self:GetCardSetCurDiffData()
  return diffData and diffData:IsCardSetDiffOpenFriend()
end

function CardSetData:GetCardSetCostReduce()
  local value = self._bonus:GetCsBonus(CardSetEnum.eCardTag.ReduceCost)
  return value
end

function CardSetData:TryCheckCsCostOk()
  if self.__playType == CardSetEnum.eSetType.rank then
    return
  end
  local battlePoint = self:GetCardSetBattlePoint()
  local diffData = self:GetCardSetCurDiffData()
  local costPoint = diffData:GetCardSetDiffCostBattlePoint()
  local costReduce = self:GetCardSetCostReduce()
  costPoint = math.max(costPoint - costReduce, 0)
  if battlePoint < costPoint then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2219))
    MsgCenter:Broadcast(eMsgEventId.OnCardSetPointDeficiency)
  end
end

function CardSetData:GetCardSetRoundInfo()
  local actId = self.__cardSetActData:GetActId()
  if self.__playType == CardSetEnum.eSetType.normal or self.__playType == CardSetEnum.eSetType.rewind then
    return ConfigData.activity_card_normal_round[actId]
  elseif self.__playType == CardSetEnum.eSetType.rank then
    return nil
  end
end

function CardSetData:GetCardSetIsLastRound(roundIndex)
  local cfgList = self:GetCardSetRoundInfo()
  if cfgList == nil then
    return false
  end
  return roundIndex == #cfgList
end

function CardSetData:_UpdRankRound()
  local roundMsg = self.__cardSetActData:GetActCsRankRoundMsg()
  for k, v in ipairs(self._rankRoundDataList) do
    local storageMsg = roundMsg[k]
    if storageMsg then
      v:UpdCsRankRoundData(storageMsg)
    else
      error("storageMsg.curRoundData is nil, roundId:" .. tostring(k))
    end
  end
end

function CardSetData:GetCsRankAllRoundScore()
  local score = 0
  for k, v in ipairs(self._rankRoundDataList) do
    score = score + v:GetCsRankRoundScore()
  end
  return score
end

function CardSetData:GetCsRankCurRoundData()
  return self._rankRoundDataList[self._curRankRoundId]
end

function CardSetData:GetCsRankCurRoundHighestScore()
  local rounData = self._rankRoundDataList[self._curRankRoundId]
  return rounData:GetCsRankRoundScore()
end

function CardSetData:IsCardSetMoreRankRound()
  return self._rankRoundDataList and #self._rankRoundDataList > 1
end

function CardSetData:SetCsRankRoundId(roundId)
  self._curRankRoundId = roundId
  local roundMsg = self.__cardSetActData:GetActCsRankRoundMsg()
  local storageMsg = roundMsg[roundId]
  self:_UpdRound(storageMsg)
  self.__cardSetActData:SetActCsRankLastRoundId(roundId)
end

function CardSetData:GetCsRankRoundId()
  return self._curRankRoundId
end

function CardSetData:GetCsRankRoundDataList()
  return self._rankRoundDataList
end

function CardSetData:GetCardSetRankBannedHeroTeaNum()
  local lockNum = 0
  for k, v in ipairs(self._rankRoundDataList) do
    local roundId = v:GetCsRankRoundId()
    if roundId ~= self._curRankRoundId and v:IsExistCsRankRoundHeroLock() then
      lockNum = lockNum + 1
    end
  end
  return lockNum
end

return CardSetData
