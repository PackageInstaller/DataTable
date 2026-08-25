local BattleCardMgrClient, Super = System.NewClass("BattleCardMgrClient")

function BattleCardMgrClient:ctor(ownerCamp)
  Super.ctor(self)
  self.realCardDeckMap = {}
  self.cardData = {}
  self.cardsChangeDeckEvent = Event()
  self:RegisterEvents()
  self.cardMap = {}
  self.camp = ownerCamp or bc.BattleCamp.Camp1
  CardDataUtils.SetHandCardCanUse(true)
end

function BattleCardMgrClient:Dispose()
  self.isDisposed = true
  self.cardsChangeDeckEvent:RemoveAllEvents()
  self:UnregisterEvents()
end

function BattleCardMgrClient:Tick(deltaTime)
  if self.isEnergyDirty then
    self.isEnergyDirty = nil
    self.isHandCardCostDirty = true
    self:OnEnergyChange()
  end
  if self.isHandCardCostDirty then
    self.isHandCardCostDirty = nil
    self:NotifyAllHandCardCostChanged()
  end
end

function BattleCardMgrClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeCardListDeck, self.OnChangeCardListDeck, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UseCard, self.OnUseCard, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MoveCardToDeck, self.OnMoveCardToDeck, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddNewCard, self.OnAddNewCard, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AfterUseCard, self.OnAfterUseCard, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ModifyCardCost, self.OnModifyCardCost, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SetCardHighlight, self.OnSetCardHighlight, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CardInteract, self.OnCardInteract, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.PropertyChanged, self.OnPropertyChanged, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CardArgsChange, self.OnCardArgsChange, self)
end

function BattleCardMgrClient:UnregisterEvents()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleCardMgrClient:OnChangeCardListDeck(data)
  if data.camp ~= self.camp then
    return
  end
  self:ChangeCardListDeck(data.cardUidList, data.oldDeck, data.newDeck, data.isShuffle, data.changeReason, data.show)
  if data.oldDeck == bc.CardDeck.DrawDeck and data.newDeck == bc.CardDeck.HandDeck then
    if data.changeReason == bc.CardDeckReason.Draw then
      AudioManager.Instance:PostSoundEvent("UI_POKER_ROUNDSTART")
    elseif data.changeReason == bc.CardDeckReason.BattleEffect then
      AudioManager.Instance:PostSoundEvent("UI_POKER_GETCARD")
    end
  end
end

function BattleCardMgrClient:OnUseCard(data)
  if data.camp and data.camp ~= self.camp then
    return
  end
  self:UseCard(data.cardUid)
end

function BattleCardMgrClient:OnCardInteract(data)
  if data.camp and data.camp ~= self.camp then
    return
  end
  local isForceUse = data.animState == CommonDefine.CardAnim.CardForceUse
  if not isForceUse and data.camp == bg.battleDataCenter:GetMyCamp() then
    return
  end
  local cardUI = bg.battlePanel:GetCardUI(data.camp)
  if cardUI then
    cardUI:OnReceiveCardInteract(data.cardUid, data.animState)
  end
end

function BattleCardMgrClient:OnMoveCardToDeck(data)
  if data.camp and data.camp ~= self.camp then
    return
  end
  self:OnMoveCardToDeck(data.cardUid, data.targetDeck, data.targetPos)
end

function BattleCardMgrClient:ProcessAudioOnAddNewCard(card, tAudioCardCreated)
  for i, v in ipairs(tAudioCardCreated) do
    if card.configId == v[1] then
      AudioManager.Instance:PostSoundEvent(v[2] or "")
    end
  end
end

function BattleCardMgrClient:OnAddNewCard(data)
  if data.camp and data.camp ~= self.camp then
    return
  end
  local cardData, deck, show = data.cards, data.deck, data.show
  local newCards = {}
  local cards = {}
  for _, v in ipairs(cardData) do
    if not v.camp then
      v.camp = self.camp
    end
    local card = BattleCardClient(v)
    if not self.cardData[card.deck] then
      self.cardData[card.deck] = {}
    end
    table.insert(self.cardData[card.deck], card)
    table.insert(cards, card)
    if card.deck and card.deck ~= bc.CardDeck.NoneDeck then
      table.insert(newCards, card)
    end
    self.cardMap[card.uid] = card
    card.index = #self.cardData[card.deck]
  end
  local bShowAudio = true
  self:CheckHandCardUse()
  self:CheckDimensionCardMax(bShowAudio)
  bg.battleDataCenter:UpdateCardDimensionStep()
  local DT = bg.DT
  local tAudioCardCreated = DT.Constant.AudioCardCreated.Data
  for _, card in ipairs(cards) do
    if card.deck and card.deck ~= bc.CardDeck.NoneDeck and card.deck == bc.CardDeck.DimensionDeck then
      AudioManager.Instance:PostSoundEvent("SFX_REALM_D_SLOT_FILL")
    end
    self:ProcessAudioOnAddNewCard(card, tAudioCardCreated)
  end
  local isAdd = false
  if deck == bc.CardDeck.HandDeck then
    isAdd = true
  elseif show and bg.battlePanel and deck ~= bc.CardDeck.NoneDeck and next(newCards) ~= nil then
    isAdd = true
  end
  bg.battlePanel:RefreshCardNum()
  if isAdd then
    bg.battlePanel:AddNewCard(newCards, data.camp)
  end
end

function BattleCardMgrClient:OnAfterUseCard(data)
  if data.camp and data.camp ~= self.camp then
    return
  end
  local cardUI = bg.battlePanel:GetCardUI(self.camp)
  if (not cardUI.usingCardUidMap or not cardUI.usingCardUidMap[data.cardUid]) and not bg.isReplay then
    Logger.Warn("BattleRender:OnUseCard warning card not in usingCardUidMap", data.cardUid)
  end
  self:AfterUseCard(data)
  local roleList = bg.battleScene.roleList
  for _, role in pairs(roleList) do
    role:OnAfterUseCard()
  end
end

function BattleCardMgrClient:OnModifyCardCost(data)
end

function BattleCardMgrClient:GetMaxHandDeckNum(cardDeck, owner)
  local upLimit = 0
  local roleDataMap = bg.battleDataCenter.roleDataModelMap
  for _, roleData in pairs(roleDataMap) do
    if roleData.camp == self.camp then
      upLimit = upLimit + (roleData:GetProperty(bc.BattleProperty.hand_deck_limit_up) or 0)
    end
  end
  local finalNum = bc.BattleAttrConst.HandCardMax + upLimit
  return finalNum
end

function BattleCardMgrClient:GetCardListByDeck(cardDeck)
  return self.cardData[cardDeck] or {}
end

function BattleCardMgrClient:SortCardUidList(cardUids)
  table.sort(cardUids, function(uidA, uidB)
    do return self.CompareCardUid, self, uidA end
    return self.CompareCardUid, self, uidA, uidB
  end)
  return cardUids
end

function BattleCardMgrClient:SortCardList(cardList, isHandCard)
  table.sort(cardList, function(a, b)
    do return self.CompareCardUid, self, a.uid, b.uid end
    return self.CompareCardUid, self, a.uid, b.uid, isHandCard
  end)
  return cardList
end

function BattleCardMgrClient:GetCardSortAwakerUid(card)
  if card.ownerUid then
    local awakerModel = bg.battleDataCenter:GetAwakerDataModel(card.ownerUid)
    if awakerModel then
      return card.ownerUid
    end
  end
  if card.ownerRoleDataMode and card.ownerRoleDataMode.uid then
    return card.ownerRoleDataMode.uid
  end
  if card.configData and card.configData.AwakerID then
    local model = bg.battleDataCenter:GetAwakerDataModelByCfgId(card.configData.AwakerID)
    if model then
      return model.uid
    end
  end
  return card.ownerUid
end

function BattleCardMgrClient:GetCardSortSkillType(card)
  local cardTypes = card:GetType()
  if cardTypes and cardTypes[1] then
    return cardTypes[1]
  end
  return card.skillType
end

function BattleCardMgrClient:CompareCardUid(uidA, uidB, isHandCard)
  if bg.isPVE then
    do return self.CompareCardUidPVE, self, uidA, uidB end
    return self.CompareCardUidPVE, self, uidA, uidB, isHandCard
  end
  do return self.CompareCardUidPVP, self, uidA, uidB end
  return self.CompareCardUidPVP, self, uidA, uidB, isHandCard
end

function BattleCardMgrClient:CompareCardUidPVE(uidA, uidB, isHandCard)
  local cardA = self:GetCardByUid(uidA)
  local cardB = self:GetCardByUid(uidB)
  local awakerUidA = cardA.ownerUid
  local awakerUidB = cardB.ownerUid
  if awakerUidA ~= awakerUidB then
    return awakerUidA < awakerUidB
  end
  local baseSortA = cardA.srcConfigData.BaseSortID
  local baseSortB = cardB.srcConfigData.BaseSortID
  if baseSortA ~= baseSortB then
    return baseSortA < baseSortB
  end
  if isHandCard then
    local handTimeA = cardA:GetHandDeckTime()
    local handTimeB = cardB:GetHandDeckTime()
    if handTimeA ~= handTimeB then
      return handTimeA < handTimeB
    end
  end
  return cardA.uid < cardB.uid
end

function BattleCardMgrClient:CompareCardUidPVP(uidA, uidB, isHandCard)
  local playerUid = bg.battleDataCenter:GetPlayerUidByCamp(self.camp)
  local cardA = self:GetCardByUid(uidA)
  local cardB = self:GetCardByUid(uidB)
  local awakerUidA = self:GetCardSortAwakerUid(cardA)
  local awakerUidB = self:GetCardSortAwakerUid(cardB)
  if awakerUidA == playerUid and awakerUidB ~= playerUid then
    return false
  end
  if awakerUidA ~= playerUid and awakerUidB == playerUid then
    return true
  end
  local skillTypeSortMap = {
    [bc.SkillType.Card_Curse] = 1,
    [bc.SkillType.Card_State] = 2,
    [bc.SkillType.Card_Potion] = 3,
    [bc.SkillType.Card_Strike] = 10,
    [bc.SkillType.Card_Defend] = 20,
    [bc.SkillType.Card_Skill] = 30,
    [bc.SkillType.Card_Extend] = 40,
    [bc.SkillType.Card_Awake] = 50
  }
  local defaultTypeSort = 9999
  local skillSortA = skillTypeSortMap[self:GetCardSortSkillType(cardA)] or defaultTypeSort
  local skillSortB = skillTypeSortMap[self:GetCardSortSkillType(cardB)] or defaultTypeSort
  if skillSortA ~= skillSortB then
    return skillSortA < skillSortB
  end
  if awakerUidA ~= awakerUidB then
    return awakerUidA > awakerUidB
  end
  local baseSortA = cardA.srcConfigData.BaseSortID
  local baseSortB = cardB.srcConfigData.BaseSortID
  if baseSortA ~= baseSortB then
    return baseSortA < baseSortB
  end
  if isHandCard then
    local handTimeA = cardA:GetHandDeckTime()
    local handTimeB = cardB:GetHandDeckTime()
    if handTimeA ~= handTimeB then
      return handTimeA < handTimeB
    end
  end
  return cardA.uid < cardB.uid
end

function BattleCardMgrClient:IsWeaponSelectCardList(cardList)
  if not cardList or 0 == #cardList then
    return false
  end
  for _, card in ipairs(cardList) do
    if not card or not self:GetWeaponCollectTidByCard(card) then
      return false
    end
  end
  return true
end

function BattleCardMgrClient:GetWeaponCollectTidByCard(card)
  if not card then
    return nil
  end
  local srcSkillTid = card.srcConfigId
  if srcSkillTid then
    local collectTid = PvpCollectCfgUtils.GetWeaponCollectTidByPvpSkillTid(srcSkillTid)
    if collectTid then
      return collectTid
    end
  end
  local skillTid = card.configId
  if skillTid then
    do return PvpCollectCfgUtils.GetWeaponCollectTidByPvpSkillTid end
    return PvpCollectCfgUtils.GetWeaponCollectTidByPvpSkillTid, skillTid
  end
  return nil
end

function BattleCardMgrClient:SortSelectCardList(cardList)
  if not cardList or #cardList <= 1 then
    return cardList
  end
  if bg.isPVP then
    self:SortPVPCardList(cardList)
  end
  return cardList
end

function BattleCardMgrClient:SortPVPCardList(cardList)
  if self:IsWeaponSelectCardList(cardList) then
    local weaponSortMap = self:GetPVPWeaponCollectSortMap()
    table.sort(cardList, function(cardA, cardB)
      local collectTidA = self:GetWeaponCollectTidByCard(cardA)
      local collectTidB = self:GetWeaponCollectTidByCard(cardB)
      local sortA = weaponSortMap[collectTidA]
      local sortB = weaponSortMap[collectTidB]
      if sortA and sortB and sortA ~= sortB then
        return sortA < sortB
      end
      local cfgA = PvpCollectCfgUtils.GetCfg(collectTidA)
      local cfgB = PvpCollectCfgUtils.GetCfg(collectTidB)
      if cfgA and cfgB and cfgA.BaseSortID ~= cfgB.BaseSortID then
        return cfgA.BaseSortID < cfgB.BaseSortID
      end
      return cardA.uid < cardB.uid
    end)
  end
end

function BattleCardMgrClient:GetPVPWeaponCollectSortMap()
  local pvpCollectionData = DataCenter.pvpCollectionData or {}
  local collectList = {}
  for collectTid, _ in pairs(pvpCollectionData.collectionMap or {}) do
    local cfg = PvpCollectCfgUtils.GetCfg(collectTid)
    if cfg and cfg.Type == CommonDefine.PVPCollectionType.Weapon and PVPCollectionDataUtils.IsOpenedInTime(collectTid) then
      table.insert(collectList, collectTid)
    end
  end
  PVPCollectionDataUtils.SortCollections(collectList)
  local sortMap = {}
  for index, collectTid in ipairs(collectList) do
    sortMap[collectTid] = index
  end
  return sortMap
end

function BattleCardMgrClient:GetHandCardList()
  local cardList = self.cardData[bc.CardDeck.HandDeck]
  do return self.SortCardList, self, cardList end
  return self.SortCardList, self, cardList, true
end

function BattleCardMgrClient:GetHandCardUidList()
  local cardList = self.cardData[bc.CardDeck.HandDeck]
  local uidList = {}
  for _, card in ipairs(cardList) do
    table.insert(uidList, card.uid)
  end
  return uidList
end

function BattleCardMgrClient:GetCardMapByDeck(cardDeck)
  local cardList = self.cardData[cardDeck]
  local cardMap = {}
  for _, card in ipairs(cardList) do
    cardMap[card.uid] = card
  end
  return cardMap
end

function BattleCardMgrClient:GetCardByDeckAndUid(cardDeck, cardUid)
  local cardData = self:GetCardListByDeck(cardDeck)
  for _, card in ipairs(cardData) do
    if card.uid == cardUid then
      return card
    end
  end
end

function BattleCardMgrClient:GetCardByUid(cardUid)
  return self.cardMap[cardUid]
end

function BattleCardMgrClient:GetCardByConfigId(cardConfigId)
  for _, v in pairs(self.cardMap) do
    if v.configId == cardConfigId then
      return v
    end
  end
end

function BattleCardMgrClient:IsHaveAvailCard()
  self:CheckHandCardUse()
  do return end
  return CardDataUtils.GetHandCardCanUse, self
end

function BattleCardMgrClient:InitAllCards(cardDataList)
  self.realCardDeckMap = {}
  self.cardData = {}
  self.cardMap = {}
  for _, v in pairs(bc.CardDeck) do
    self.cardData[v] = {}
  end
  for _, config in ipairs(cardDataList) do
    config.camp = self.camp
    local card = BattleCardClient(config)
    if self.cardData[card.deck] then
      table.insert(self.cardData[card.deck], card)
    end
    self.cardMap[card.uid] = card
    self.realCardDeckMap[card.uid] = card.deck
  end
  self:OnSetCardHighlight({
    highlightList = bg.battleDataCenter.highlightList
  })
  self:CheckDimensionCardMax()
end

function BattleCardMgrClient:HasAnyCardAvailableInHand(energy)
  local handDeck = self.cardData[bc.CardDeck.HandDeck]
  if 0 == #handDeck then
    return false
  end
  for _, card in ipairs(handDeck) do
    if energy >= card:GetCost() then
      return true
    end
  end
  return false
end

function BattleCardMgrClient:OnPropertyChanged(data)
  if data.propertyType == bc.BattleProperty.energy then
    self.isEnergyDirty = true
  end
  local apiCfg = DT.BattleApi[data.propertyType]
  if not apiCfg then
    return
  end
  if apiCfg.ApiType == bc.ApiType.CARD_ATTR then
    local card = self:GetCardByUid(data.uid)
    if card then
      card:OnPropertyChanged(data)
    end
  else
    self.isHandCardCostDirty = true
  end
end

function BattleCardMgrClient:NotifyAllHandCardCostChanged()
  local handDeck = self.cardData[bc.CardDeck.HandDeck]
  if not handDeck then
    return
  end
  for _, card in ipairs(handDeck) do
    card:NotifyCostChanged()
  end
end

function BattleCardMgrClient:OnChangeBoutPhase(data)
  if data.newPhase == bc.BoutPhase.Action then
    self:CheckHandCardUse()
  end
end

function BattleCardMgrClient:OnEnergyChange()
  self:CheckHandCardUse()
end

function BattleCardMgrClient:CheckHandCardUse()
  local handDeck = self.cardData[bc.CardDeck.HandDeck]
  if 0 == #handDeck then
    CardDataUtils.SetHandCardCanUse(false)
    return false
  end
  local canUse = false
  for _, card in ipairs(handDeck) do
    if card:CheckUsable() then
      canUse = true
    end
  end
  CardDataUtils.SetHandCardCanUse(canUse)
  return canUse
end

function BattleCardMgrClient:OnBoutStart()
  local handDeck = self.cardData[bc.CardDeck.HandDeck]
  if 0 == #handDeck then
    return false
  end
  for _, card in ipairs(handDeck) do
    card:CheckUsable()
  end
end

function BattleCardMgrClient:UseCard(cardUid)
  local card = bg.battleRender.cardMgr:GetCardByUid(cardUid)
  bg.battlePanel:OnUseCard(card.uid, card.deck)
  local pvpOppositePanel = UIManager.Instance:GetWindow(Urls.PvPBattleOppsiteMainPanel)
  if pvpOppositePanel then
    pvpOppositePanel:OnUseCard(card.uid, card.deck)
  end
end

function BattleCardMgrClient:ChangeRealCardDeck(recordData)
  local data = recordData and recordData.data or {}
  if data.cardUidList and data.newDeck then
    for _, cardUid in ipairs(data.cardUidList) do
      self.realCardDeckMap[cardUid] = data.newDeck
    end
  elseif data.cardUid and data.targetDeck then
    self.realCardDeckMap[data.cardUid] = data.targetDeck
  elseif data.cards and data.deck then
    for _, card in ipairs(data.cards) do
      self.realCardDeckMap[card.uid] = data.deck
    end
  end
end

function BattleCardMgrClient:GetCardRealDeck(cardUid)
  return self.realCardDeckMap[cardUid]
end

function BattleCardMgrClient:ChangeCardListDeck(cardUidList, oldDeck, newDeck, isShuffle, reason, show)
  local cardList = {}
  local oldMinIndex = math.maxinteger
  local oldCardList = self.cardData[oldDeck] or {}
  local changeList = {}
  for index = #oldCardList, 1, -1 do
    local card = oldCardList[index]
    local isTargetUid = false
    for _, targetUid in ipairs(cardUidList) do
      if targetUid == card.uid then
        isTargetUid = true
        break
      end
    end
    if not isTargetUid then
    else
      oldMinIndex = index < oldMinIndex and index or oldMinIndex
      table.remove(oldCardList, index)
      changeList[card.uid] = card
    end
  end
  for _, targetUid in ipairs(cardUidList) do
    local card = self:GetCardByUid(targetUid)
    if not card then
      Logger.Info("ChangeCardListDeck failed: card not found", targetUid)
    else
      table.insert(cardList, card)
      if changeList[targetUid] then
        if not self.cardData[newDeck] then
          self.cardData[newDeck] = {}
        end
        table.insert(self.cardData[newDeck], card)
        card:ChangeCardDeck(newDeck, reason)
        card.index = #self.cardData[newDeck]
      end
    end
  end
  for index = #oldCardList, oldMinIndex, -1 do
    local card = oldCardList[index]
    card.index = index
  end
  self:CheckHandCardUse()
  self:CheckDimensionCardMax()
  BattleHandCardLogUtils.LogDeckChangeData(self, cardList, oldDeck, newDeck, reason, show)
  self.cardsChangeDeckEvent:Dispatch(cardList, oldDeck, newDeck, isShuffle, reason, show)
  bg.battleDataCenter:UpdateCardDimensionStep()
end

function BattleCardMgrClient:ModifyCardCost(data)
  local card = self:GetCardByUid(data.cardUid)
  if card then
    card:SetCost(data.value)
  end
  self:CheckHandCardUse()
end

function BattleCardMgrClient:RemoveCardByEffect(msgData)
  local cardData = self.cardData[msgData.cardDeck] or {}
  if not cardData then
    return
  end
  local DT = bg.DT
  for i = #cardData, 1, -1 do
    if cardData[i].uid == msgData.cardUid then
      local desc = LT.Textf(DT.TipsType[10119].Desc, cardData[i].configData.ID, cardData[i].uid)
      Alert.Show(10119, nil, nil, nil, desc)
      table.remove(cardData, i)
      self.cardMap[msgData.cardUid] = nil
      break
    end
  end
end

function BattleCardMgrClient:OnSetCardHighlight(data)
  local highlightList = data.highlightList or {}
  local handDeck = self.cardData[bc.CardDeck.HandDeck]
  for _, card in ipairs(handDeck or {}) do
    card:SetHighlightEffect(highlightList[card.uid])
  end
end

function BattleCardMgrClient:AfterUseCard(data)
  local card = bg.battleRender.cardMgr:GetCardByUid(data.cardUid)
  if card then
    card:SetLeftUseCount(data.leftUseCount)
  end
  self:CheckHandCardUse()
end

function BattleCardMgrClient:CheckDimensionCardMax(bShowAudio)
  local playerRole = bg.battleScene:GetPlayerRole()
  local dimensionNum = #self.cardData[bc.CardDeck.DimensionDeck]
  local max = playerRole:GetProperty(bc.BattleProperty.dimension_slot)
  local bFilledMax = dimensionNum >= max and max > 0
  CardDataUtils.SetDimensionCardNum(dimensionNum)
  CardDataUtils.SetDimensionCardMax(bFilledMax)
  if bShowAudio and bFilledMax then
    AudioManager.Instance:PostSoundEvent("SFX_REALM_D_SLOT_MAX")
  end
end

function BattleCardMgrClient:OnCardArgsChange(data)
  for uid, args in pairs(data) do
    local card = self:GetCardByUid(uid)
    if card then
      card:UpdateCardArgs(args)
    end
  end
end

function BattleCardMgrClient:PrintDebugLog()
end

return BattleCardMgrClient
