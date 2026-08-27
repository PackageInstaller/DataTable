local ReinforceCardDataAll = class("ReinforceCardDataAll")
local UserInfoData = require("Game.User.UserInfoData")
local ReinforceCardDataSystem = require("Game.Reinforce.Data.ReinforceCardDataSystem")
local ReinforceCardDataFactor = require("Game.Reinforce.Data.ReinforceCardDataFactor")

function ReinforceCardDataAll:InitRfCardDataAll(msg, activityId)
  self._cardSysDic = {}
  self._factorCardSupportDic = {}
  self._activityId = activityId
  if msg == nil then
    return
  end
  for cardId, elem in pairs(msg.cards) do
    self:_AddSysCard(elem)
  end
  self:UpdateAssisFactorCards(msg.assisFactorCards)
end

function ReinforceCardDataAll:GetRfCdAllActFrameId()
  return self._activityId
end

function ReinforceCardDataAll:UpdRfCardDataAll(msg)
  local sysCardChange = false
  for cardId, elem in pairs(msg.cards) do
    local cardData = self._cardSysDic[cardId]
    if cardData == nil then
      self:_AddSysCard(elem)
    else
      cardData:UpdRfCardDataSys(elem)
    end
    sysCardChange = true
  end
  if sysCardChange then
    MsgCenter:Broadcast(eMsgEventId.ReinforceCardSysChange)
  end
  self:UpdateAssisFactorCards(msg.assisFactorCards)
end

function ReinforceCardDataAll:UpdRfCardGroupListData(msg)
  self.rfGroupList = {}
  local maxNum = ConfigData.reinforce_exploration_main[self._activityId].slots_num
  for i = 1, maxNum do
    local data = msg.factorCardStartData[i]
    if data ~= nil then
      self.rfGroupList[data.groupId] = {
        groupId = data.groupId,
        reinforceCardId = data.reinforceCardId,
        factorCardId = data.factorCardId,
        friendFactorCardId = data.friendFactorCardId,
        name = data.name
      }
    else
      self.rfGroupList[i] = {
        groupId = i,
        reinforceCardId = {},
        factorCardId = 0,
        friendFactorCardId = 0,
        name = nil
      }
    end
  end
end

function ReinforceCardDataAll:UpdateAssisFactorCards(assisFactorCards)
  local friendFactorMaxCount = self:GetFriendFactorMaxCount()
  for i = 1, friendFactorMaxCount do
    if assisFactorCards[i] ~= 0 then
      self._factorCardSupportDic[i] = assisFactorCards[i]
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ReinforceFactorSupportCardChange, self._factorCardSupportDic)
end

function ReinforceCardDataAll:GetRfCardGroup()
  return self.rfGroupList
end

function ReinforceCardDataAll:GetRfCardGroupByGroupId(groupId)
  return self.rfGroupList[groupId]
end

function ReinforceCardDataAll:_AddSysCard(msgElem)
  local cardSysData = ReinforceCardDataSystem.New()
  cardSysData:InitRfCardDataSysByElem(msgElem)
  self._cardSysDic[msgElem.cardId] = cardSysData
end

function ReinforceCardDataAll:GetRfCardSysDataDic()
  return self._cardSysDic
end

function ReinforceCardDataAll:GetRfCardSysDataById(cardId)
  return self._cardSysDic[cardId]
end

function ReinforceCardDataAll:GetCardCollectionPackRate(themeId, actId)
  local cardIdList = ConfigData.reinforce_card_card_main.packGroup[self._activityId][themeId]
  local packCardStarCount = 0
  local collectionCardStarCount = 0
  for index, cardId in ipairs(cardIdList) do
    packCardStarCount = packCardStarCount + ConfigData.reinforce_collect_card_main[actId].star_score3
    local cardSys = self:GetRfCardSysDataById(cardId)
    if cardSys ~= nil then
      collectionCardStarCount = collectionCardStarCount + cardSys:GetRfCardStarScore(actId)
    end
  end
  return collectionCardStarCount / packCardStarCount, collectionCardStarCount, packCardStarCount
end

function ReinforceCardDataAll:GetShopCardCollectionPackRate(poolId, actId)
  local cardIdList = ConfigData.reinforce_pool_card_pool[poolId]
  local packCardStarCount = 0
  local collectionCardStarCount = 0
  for index, poolCfg in pairs(cardIdList) do
    for cardId, count in pairs(poolCfg.card) do
      packCardStarCount = packCardStarCount + ConfigData.reinforce_collect_card_main[actId].star_score3
      local cardSys = self:GetRfCardSysDataById(cardId)
      if cardSys ~= nil then
        collectionCardStarCount = collectionCardStarCount + cardSys:GetRfCardStarScore(actId)
      end
    end
  end
  return collectionCardStarCount / packCardStarCount, collectionCardStarCount, packCardStarCount
end

function ReinforceCardDataAll:GetAllCardCollectionPackRate(actId)
  local collectCfgList = ConfigData.reinforce_collect_collect_theme[actId]
  local allCollectionCardStarCount = 0
  local allPackCardStarCount = 0
  for theme_id, collectCfg in pairs(collectCfgList) do
    local collectionRate, collectionCardStarCount, packCardStarCount = self:GetCardCollectionPackRate(theme_id, actId)
    allCollectionCardStarCount = allCollectionCardStarCount + collectionCardStarCount
    allPackCardStarCount = allPackCardStarCount + packCardStarCount
  end
  return allCollectionCardStarCount / allPackCardStarCount, allCollectionCardStarCount, allPackCardStarCount
end

function ReinforceCardDataAll:IsExistCardCanLvUp(themeId)
  for cardId, card in pairs(self._cardSysDic) do
    if themeId == card._rfCdMainCfg.collect_theme and card:IsCanLvUp() then
      return true
    end
  end
  return false
end

function ReinforceCardDataAll:InitRfFactorCardDataDic(msg)
  self._factorCardDic = {}
  for cardId, v in pairs(msg.factorCards) do
    local cardData = ReinforceCardDataFactor.New()
    cardData:InitRfCardDataFac(v)
    self._factorCardDic[cardId] = cardData
  end
end

function ReinforceCardDataAll:GetRfFactorCardDataDic()
  return self._factorCardDic
end

function ReinforceCardDataAll:AddRfFactorCardData(facCardData)
  if self._factorCardDic == nil then
    return
  end
  self._factorCardDic[facCardData:GetRfCdFactorOrder()] = facCardData
end

function ReinforceCardDataAll:GetRfEpMainCfg()
  local rfEpMainCfg = ConfigData.reinforce_exploration_main[self._activityId]
  return rfEpMainCfg
end

function ReinforceCardDataAll:GetFriendFactorMaxCount()
  return self:GetRfEpMainCfg().set_friend_factor
end

function ReinforceCardDataAll:GetAvailableRfFactorCardAsSupportPos()
  for i = 1, self:GetFriendFactorMaxCount() do
    if self._factorCardSupportDic[i] == nil then
      return i
    end
  end
  return -1
end

function ReinforceCardDataAll:GetRfFactorCardAsSupportPosByCardOrderId(cardOrderId)
  for i = 1, self:GetFriendFactorMaxCount() do
    if cardOrderId ~= nil and self._factorCardSupportDic[i] == cardOrderId then
      return i
    end
  end
  return -1
end

function ReinforceCardDataAll:GetRfFactorCardAsSupport()
  return self._factorCardSupportDic
end

function ReinforceCardDataAll:SetRfFactorCardAsSupport(supportPos, cardOrderId)
  local friendFactorCount = self:GetFriendFactorMaxCount()
  if supportPos <= 0 or supportPos > friendFactorCount then
    return
  end
  self.isNeedSaveFactorCardAsSupport = true
  if cardOrderId == nil then
    self._factorCardSupportDic[supportPos] = nil
    MsgCenter:Broadcast(eMsgEventId.ReinforceFactorSupportCardChange, self._factorCardSupportDic)
    return
  end
  if self._factorCardDic == nil or self._factorCardDic[cardOrderId] == nil then
    return
  end
  for i = 1, friendFactorCount do
    if self._factorCardSupportDic[i] == cardOrderId and i ~= supportPos then
      self._factorCardSupportDic[i] = nil
    end
  end
  self._factorCardSupportDic[supportPos] = cardOrderId
  MsgCenter:Broadcast(eMsgEventId.ReinforceFactorSupportCardChange, self._factorCardSupportDic)
end

function ReinforceCardDataAll:SaveRfFactorCardAsSupport(callback)
  if not self.isNeedSaveFactorCardAsSupport then
    if callback ~= nil then
      callback()
    end
    return
  end
  local reinforceNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Reinforce)
  local cards = {}
  local idxs = {}
  local friendFactorCount = self:GetFriendFactorMaxCount()
  for i = 1, friendFactorCount do
    table.insert(idxs, i)
    if self._factorCardSupportDic[i] ~= nil then
      table.insert(cards, self._factorCardDic[self._factorCardSupportDic[i]]:GetRfCdFactorOrder())
    else
      table.insert(cards, 0)
    end
  end
  reinforceNetCtrl:CS_SetAssisFactorCards(self._activityId, cards, idxs, callback)
  self.isNeedSaveFactorCardAsSupport = false
end

function ReinforceCardDataAll:GetAllSupportFactCardData(overCallback, forceRefresh)
  local allSupportCardDic, nextFreshTm, friendsBanData, strangerUserInfoDic
  
  local function AddCardData(userInfoData, assistFactorElem)
    if assistFactorElem.uuid == 0 then
      return
    end
    local userUID = userInfoData:GetUserUID()
    if allSupportCardDic[userUID] == nil then
      allSupportCardDic[userUID] = {}
    end
    local supportCardData = ReinforceCardDataFactor.New()
    supportCardData:InitRfCardDataFac(assistFactorElem)
    supportCardData:SetSupportData(true, userInfoData)
    local uid = supportCardData:GetRfCdUID()
    allSupportCardDic[userUID][uid] = supportCardData
  end
  
  local cachedData = self.cachedSupportData or table.emptytable
  local c_allSupportCardDic = cachedData.allSupportCardDic
  local c_nextFreshTm = cachedData.nextFreshTm
  local c_friendsBanData = cachedData.friendsBanData
  local c_userInfoDic = cachedData.strangerUserInfoDic
  if c_allSupportCardDic == nil or forceRefresh then
    strangerUserInfoDic = {}
    local objNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Object)
    objNetworkCtrl:CS_ASSISTANT_FetchStranger(function(args)
      allSupportCardDic = {}
      local strangerMsg
      if args ~= nil and args.Count > 0 then
        strangerMsg = args[0]
      end
      for userUID, avatarMsg in pairs(strangerMsg.avatar) do
        local userInfoData = UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
        strangerUserInfoDic[userUID] = userInfoData
        for _, assistFactorElem in pairs(userInfoData:GetSupportFactCardList()) do
          AddCardData(userInfoData, assistFactorElem)
        end
      end
      for _, userInfoData in pairs(PlayerDataCenter.friendDataCenter:GetFreindList()) do
        for _, assistFactorElem in pairs(userInfoData:GetSupportFactCardList()) do
          AddCardData(userInfoData, assistFactorElem)
        end
      end
      friendsBanData = strangerMsg.friendsBan
      nextFreshTm = strangerMsg.nextFreshTm
      self.cachedSupportData = {
        allSupportCardDic = allSupportCardDic,
        nextFreshTm = nextFreshTm,
        friendsBanData = friendsBanData,
        strangerUserInfoDic = strangerUserInfoDic
      }
      overCallback(allSupportCardDic, nextFreshTm, friendsBanData, strangerUserInfoDic)
    end, true)
  else
    allSupportCardDic = c_allSupportCardDic
    friendsBanData = c_friendsBanData
    nextFreshTm = c_nextFreshTm
    strangerUserInfoDic = c_userInfoDic
    for UID, userInfoData in pairs(strangerUserInfoDic) do
      if PlayerDataCenter.friendDataCenter:TryGetFriendData(UID) ~= nil then
        strangerUserInfoDic[UID] = nil
      end
    end
    for _, userInfoData in pairs(PlayerDataCenter.friendDataCenter:GetFreindList()) do
      local userUID = userInfoData:GetUserUID()
      allSupportCardDic[userUID] = {}
      for _, assistFactorElem in pairs(userInfoData:GetSupportFactCardList()) do
        AddCardData(userInfoData, assistFactorElem)
      end
    end
    overCallback(allSupportCardDic, nextFreshTm, friendsBanData, strangerUserInfoDic)
  end
end

function ReinforceCardDataAll:TryGetSupportFacCardByUID(uid, callback)
  self:GetAllSupportFactCardData(function(allSupportCardDic, nextFreshTm, friendsBanData, strangerUserInfoDic)
    if allSupportCardDic ~= nil then
      for userUID, dic in pairs(allSupportCardDic) do
        for cardUid, cardData in pairs(dic) do
          if cardUid == uid then
            if callback ~= nil then
              callback(cardData)
            end
            return
          end
        end
      end
    end
    if callback ~= nil then
      callback(nil)
    end
  end)
end

return ReinforceCardDataAll
