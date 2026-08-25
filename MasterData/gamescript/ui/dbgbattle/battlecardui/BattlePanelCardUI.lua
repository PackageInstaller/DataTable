local CardDeck = bc.CardDeck
local RectTransform = CS.UnityEngine.RectTransform
local CardAnim = CommonDefine.CardAnim
local typeof = _ENV.typeof
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local DOTween = CS.DG.Tweening.DOTween
local Tweening = CS.DG.Tweening
local TrailRenderer = CS.UnityEngine.TrailRenderer
local Quaternion = CS.UnityEngine.Quaternion
local Application = CS.UnityEngine.Application
local ENEMY_CARD_RATE = 0.6
local BattlePanelCardUI, Super = System.NewComponent("BattlePanelCardUI")

function BattlePanelCardUI:ctor(cardUIDelegate, cardMgr, myCamp, battlePanel)
  Super.ctor(self)
  self.uiDelegate = cardUIDelegate
  self.ui = cardUIDelegate.ui
  self.cardItemMap = {}
  self.cardItemSet = {}
  self.handIndexCardItemMap = {}
  self.deckCardNum = Vue.ref(0)
  self.graveyardNum = Vue.ref(0)
  self.handCardNum = Vue.ref(0)
  self.cardTweeners = {}
  self.isPVPSelecting = Vue.ref(false)
  self.embryoBornEffects = nil
  self.swallowEmbryoEffects = nil
  self.sector = Sector(-CommonDefine.SectorAngle, CommonDefine.SectorAngle, CommonDefine.SectorShift, CommonDefine.MaxDeltaAngle)
  self.cardMgr = cardMgr
  self.camp = cardMgr.camp or bc.BattleCamp.Camp1
  self.myCamp = myCamp or bc.BattleCamp.Camp1
  self.checkCard = nil
  self._previewCard = nil
  self.checkCardState = CommonDefine.CardCheck.None
  self._previewCardState = CommonDefine.CardCheck.None
  self.battlePanel = battlePanel
  if self.battlePanel then
    self.battlePanel.cardUI = self
  end
  self.opMode = Vue.ref(bg.battleDataCenter.opMode)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattlePanelCardUI:OnBind(binder)
  self.binder = binder
  self.deckRectTransform = self.uiDelegate:GetCardContent():GetComponent(typeof(RectTransform))
  local deckSize = self.deckRectTransform.sizeDelta
  self.sector:SetWidth(deckSize.x - CommonDefine.SectorPadding * 2)
  self.battleCardPool = self:CreateCardPool()
  self.cardLifecycle = BattleCardItemLifecycle(self)
  self:InitCardDeckBtn()
  binder:BindEvent(self.cardMgr.cardsChangeDeckEvent, System.fn(self, self.OnCardChangeDeck))
  if self:IsMyCamp() then
    binder:BindEvent(EventMgr.Instance.SettingShortCut, System.fn(self, self._OnSettingShortCut))
    binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self._OnTouchEndEvent))
    binder:BindEvent(EventMgr.Instance.BattleEndTurnClicked, System.fn(self, self._OnBattleEndTurnCancelPreview))
  end
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SelectCardEffect, self.OnSelectCardEffect, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SelectMoveCardResult, self.OnSelectMoveCardResult, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CardDisplayChange, self.OnCardDisplayChange, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AddNewCard, self.OnAddNewCard, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BattleFinish, self.OnBattleFinish, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeCardId, self.OnChangeCardId, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.PlayCardVFX, self.OnPlayCardVFX, self)
  self:InitHandCard()
  self._lastAppFocused = Application.isFocused
  self.binder:BindTimer(0.5, -1, System.fn(self, self.CheckFingerCount))
  self.binder:BindTimer(0.1, -1, System.fn(self, self.CheckResetHandCard))
  binder:BindEvent(EventMgr.Instance.SelectInitCardAnimStart, System.fn(self, self.HideCardContent))
  binder:BindEvent(EventMgr.Instance.SelectInitCardAnimEnd, System.fn(self, self.ShowCardContent))
  binder:BindEvent(EventMgr.Instance.PVPAwakerSelectCancel, System.fn(self, self.OnPVPAwakerSelectCancel))
  binder:BindEvent(EventMgr.Instance.PVPViewChange, System.fn(self, self.OnPVPViewChange))
  if self:IsMyCamp() then
    binder:BindEvent(EventMgr.Instance.CardBlowUp, System.fn(self, self.OnCardBlowUp))
  end
end

function BattlePanelCardUI:_OnTouchEndEvent()
  self:PutBackPreviewCard()
end

function BattlePanelCardUI:_OnBattleEndTurnCancelPreview(camp)
  if camp ~= self.myCamp then
    return
  end
  self:PutBackPreviewCard()
  self:CancelActiveCardDrag()
end

function BattlePanelCardUI:OnBattleFinish()
  if not self:IsMyCamp() then
    return
  end
  self:PutBackPreviewCard()
  self:CancelActiveCardDrag()
end

function BattlePanelCardUI:SetCheckCard(cardItem)
  if self.checkCard and self.checkCard ~= cardItem then
    self.checkCard:SetVxChooseShow(false)
  end
  self.checkCard = cardItem
end

function BattlePanelCardUI:IsCardShortCutBlocked()
  if not bg.battleRender then
    return false
  end
  if bg.battleRender:IsInSelectCard() then
    return true
  end
  if bg.battleRender:IsBattleActionShortCutBlocked() then
    return true
  end
  return false
end

function BattlePanelCardUI:_OnSettingShortCut(uName)
  if self:IsCardShortCutBlocked() then
    return
  end
  local targetHandIdx
  local maxHandIdx = self:GetCardMaxHandIdx()
  if not maxHandIdx or 0 == maxHandIdx then
    return
  end
  local draggingCardHandIdx = math.ceil(maxHandIdx / 2)
  local draggingCardItem = self:GetSelectingCardItem()
  if draggingCardItem then
    draggingCardHandIdx = draggingCardItem:GetHandIndex()
  end
  if "KeyLeft" == uName then
    targetHandIdx = draggingCardHandIdx - 1
    if targetHandIdx <= 0 then
      targetHandIdx = maxHandIdx
    end
    self:_OnShortCutLeftOrRight(targetHandIdx, uName)
  elseif "KeyRight" == uName then
    targetHandIdx = draggingCardHandIdx + 1
    if maxHandIdx < targetHandIdx then
      targetHandIdx = 1
    end
    self:_OnShortCutLeftOrRight(targetHandIdx, uName)
  elseif "KeyConfirm" == uName then
    UIManager.Instance:CloseByUrl(Urls.CommonCardKeyWorldDescPanel)
    ShortCutKeyManager.Instance:TriggerShortCut(uName, function()
      if draggingCardItem then
        draggingCardItem:ShortCutUse()
        self:PutBackPreviewCard()
        BattleCardShotcutDragDropMgr.Instance:StopDragCard()
      end
    end)
  end
end

function BattlePanelCardUI:_OnShortCutLeftOrRight(targetHandIdx, keyName)
  local targetCardItem = self:GetCardByHandIdx(targetHandIdx)
  ShortCutKeyManager.Instance:TriggerShortCut(keyName, function()
    if targetCardItem then
      self:ShowCardItemPreview(targetCardItem)
    end
  end)
end

function BattlePanelCardUI:GetNewCardItem()
  do return self.battleCardPool.Get, self.battleCardPool, self.binder, self.uiDelegate:GetCardContent() end
  return self.battleCardPool.Get, self.battleCardPool, self.binder, self.uiDelegate:GetCardContent()
end

function BattlePanelCardUI:InitCardDeckBtn()
  self.binder:BindComponent(BattleDrawBtnItem(self.uiDelegate:GetDrawDeckBtn(), self.cardMgr, self.deckCardNum, self.graveyardNum, CardDeck.DrawDeck, self.myCamp))
  if self.uiDelegate:GetHandDeckBtn() then
    self.binder:BindComponent(BattleDrawBtnItem(self.uiDelegate:GetHandDeckBtn(), self.cardMgr, self.handCardNum, 0, CardDeck.HandDeck, self.myCamp))
  end
end

function BattlePanelCardUI:CheckFingerCount()
  if ApplicationUtils.IsWindowsOrEditor() then
    if not self:IsMyCamp() then
      return
    end
    local focused = Application.isFocused
    if focused == self._lastAppFocused then
      return
    end
    self._lastAppFocused = focused
    if not focused then
      self:CancelActiveCardDrag()
    end
    return
  end
  local fingerCount = InputManager.Instance:GetFingerCount()
  if 0 == fingerCount and self.checkCard and self.checkCardState == CommonDefine.CardCheck.Display then
    self:ResetCheckCard(true)
  end
end

function BattlePanelCardUI:CancelActiveCardDrag()
  if bg.isReplay then
    return
  end
  if BattleCardShotcutDragDropMgr.Instance:GetDraggingCardItem() then
    BattleCardShotcutDragDropMgr.Instance:StopDragCard()
    return
  end
  local checkCard = self.checkCard
  if not checkCard then
    return
  end
  if not self:IsInHandMap(checkCard) then
    self.touchDownX = nil
    self.touchDownY = nil
    self:CheckCardInit(nil)
    self:ResetSiblingIndex()
    return
  end
  if self:IsUsingCardItem(checkCard) then
    return
  end
  local inActiveDrag = nil ~= self.touchDownY or checkCard:IsInState(CardAnim.CardDrag) or self.checkCardState == CommonDefine.CardCheck.Display or self.checkCardState == CommonDefine.CardCheck.Ready
  if not inActiveDrag then
    return
  end
  checkCard.isFingerPressing = false
  checkCard.isTouchValid = false
  if self.checkCardState == CommonDefine.CardCheck.Display then
    AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Show_Card_Withdraw")
    self:SetCardAnimState(checkCard, CommonDefine.CardAnim.CardDisplayBack)
  else
    AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Withdraw")
    self:SetCardAnimState(checkCard, CommonDefine.CardAnim.CardPutBack)
  end
  self.touchDownX = nil
  self.touchDownY = nil
  self:CheckCardInit(nil)
  self:ResetSiblingIndex()
end

function BattlePanelCardUI:IsMyCamp()
  return self.camp == self.myCamp
end

function BattlePanelCardUI:CreateCardPool()
  local isMyCamp = self:IsMyCamp()
  local cardCls = isMyCamp and BattleCardItem or BattleCardBackItem
  local cardRes = isMyCamp and Item_Battle_Card_1Resource or Item_Battle_Card_Back_1Resource
  do return Pool.CreateWithCreator, cardCls, 0, function(b, parent)
    do return b.BindNewComponent, b, parent, cardCls, cardRes, nil, nil end
    return b.BindNewComponent, b, parent, cardCls, cardRes, nil, nil, self.myCamp
  end, self.binder, self.uiDelegate:GetCardContent() end
  return Pool.CreateWithCreator, cardCls, 0, function(b, parent)
    do return b.BindNewComponent, b, parent, cardCls, cardRes, nil, nil end
    return b.BindNewComponent, b, parent, cardCls, cardRes, nil, nil, self.myCamp
  end, self.binder, self.uiDelegate:GetCardContent()
end

function BattlePanelCardUI:InitHandCard()
  local cardList = self.cardMgr:GetHandCardList()
  for index, card in ipairs(cardList) do
    card.index = index
  end
  BattleHandCardLogUtils.LogInfo("InitHandCard", self, string.format("uids=%s", BattleHandCardLogUtils.FormatCardUidList(cardList)))
  self:OnCardChangeDeck(cardList, nil, bc.CardDeck.HandDeck, false, nil, true)
  self.cardMgr:CheckHandCardUse()
end

function BattlePanelCardUI:CreateSelectedCard()
  self.isPVPSelecting.value = true
end

function BattlePanelCardUI:OnBeginSelectBack()
  self:RefreshCardNum()
  local handCardDataList = self.cardMgr:GetHandCardList()
  if bg.isReplay then
    self:BindReplayHandCardsToMap()
  end
  for index, cardData in ipairs(handCardDataList) do
    local cardItem = self.cardItemMap[cardData]
    if cardItem then
      cardItem:SetHandIndex(index)
    end
  end
  self:RebuildCardItemCache()
end

function BattlePanelCardUI:OnSelectBack(cardItem)
  local cardClient = cardItem.card.value
  if cardClient then
    local nativeCardItem = self.cardItemMap[cardClient]
    if nativeCardItem and nativeCardItem ~= cardItem then
      self:RemoveCards({cardClient}, true)
    end
    self.cardItemMap[cardClient] = cardItem
    self:UpdateCardItemCache(cardItem)
  end
  local cardContent = self.uiDelegate:GetCardContent()
  if IsNil(cardContent) then
    return
  end
  cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
  cardItem:Init(cardClient, self.uiDelegate:GetCardContent().transform, self:GetCardTouchFuncs())
  self:SetCardAnimState(cardItem, CardAnim.CardSelectBack)
end

function BattlePanelCardUI:OnSelectCancel(cardItem)
  local cardClient = cardItem and cardItem.card.value
  if cardClient and cardClient.deck ~= bc.CardDeck.HandDeck then
    cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
    self:RemoveCards({
      cardItem.card.value
    }, true)
  end
end

function BattlePanelCardUI:IsLeaveHandDeckChange(oldDeck, newDeck)
  return oldDeck == bc.CardDeck.HandDeck and newDeck ~= bc.CardDeck.HandDeck
end

function BattlePanelCardUI:TryReplayCleanupLeftHandCards(cards, newDeck, show)
  if not (bg.isReplay and cards) or 0 == #cards then
    return
  end
  local handMap = self.cardMgr:GetCardMapByDeck(bc.CardDeck.HandDeck)
  local staleCards = {}
  for _, card in ipairs(cards) do
    if not handMap[card.uid] and self:GetCardItemByUid(card.uid) then
      table.insert(staleCards, card)
    end
  end
  if 0 == #staleCards then
    return
  end
  if newDeck == bc.CardDeck.GraveyardDeck or newDeck == bc.CardDeck.DrawDeck then
    self:MoveCardToGraveyard(staleCards, show)
  elseif newDeck == bc.CardDeck.ConsumedDeck or newDeck == bc.CardDeck.SwallowDeck then
    self:SetCardsAnimState(staleCards, CommonDefine.CardAnim.CardConsume)
  elseif newDeck == bc.CardDeck.UsingDeck then
    if bg.isReplay then
      self:SetCardsAnimState(staleCards, CommonDefine.CardAnim.CardRecordUse, function()
        if not self.ui or IsNil(self.ui.uiNode) then
          return
        end
        bg.battleRender:PerformWithDelay(0.03, function()
          self:SetCardsAnimState(staleCards, CommonDefine.CardAnim.CardDisappear)
        end, self)
      end)
    else
      self:SetCardsAnimState(staleCards, CommonDefine.CardAnim.CardDisappear)
    end
  else
    self:SetCardsAnimState(staleCards, CommonDefine.CardAnim.CardDisappear)
  end
  self:RemoveCards(staleCards, false)
  self:CheckResetHandCard()
end

function BattlePanelCardUI:OnCardChangeDeck(cards, oldDeck, newDeck, _, reason, show)
  if self.isPVPSelecting.value and (oldDeck == bc.CardDeck.SelectInitDeck or newDeck == bc.CardDeck.SelectInitDeck) then
    BattleHandCardLogUtils.LogAnomaly("SkipSelectInitDeckChange", self, string.format("old=%s new=%s reason=%s show=%s uids=%s", BattleHandCardLogUtils.FormatDeck(oldDeck), BattleHandCardLogUtils.FormatDeck(newDeck), tostring(reason), tostring(show), BattleHandCardLogUtils.FormatCardUidList(cards)))
    return
  end
  if not self._changeCardDeckList then
    self._changeCardDeckList = {}
    self.binder:BindToRaw(function(_, isVisble)
      if isVisble then
        for i = 1, #self._changeCardDeckList do
          self:DealCardChangeDeck(table.unpack(self._changeCardDeckList[i]))
        end
        self._changeCardDeckList = {}
      end
      return self._changeCardDeckList
    end, function()
      do return bg.battlePanel.GetUIVisible end
      return bg.battlePanel.GetUIVisible, bg.battlePanel
    end)
  end
  local isLeaveHand = self:IsLeaveHandDeckChange(oldDeck, newDeck)
  if bg.battlePanel:GetUIVisible() or bg.isReplay and isLeaveHand then
    self:DealCardChangeDeck(cards, oldDeck, newDeck, _, reason, show)
  else
    BattleHandCardLogUtils.LogAnomaly("DeferUIHiddenDeckChange", self, string.format("old=%s new=%s reason=%s show=%s uids=%s", BattleHandCardLogUtils.FormatDeck(oldDeck), BattleHandCardLogUtils.FormatDeck(newDeck), tostring(reason), tostring(show), BattleHandCardLogUtils.FormatCardUidList(cards)))
    table.insert(self._changeCardDeckList, {
      cards,
      oldDeck,
      newDeck,
      _,
      reason,
      show
    })
  end
end

function BattlePanelCardUI:DealCardChangeDeck(cards, oldDeck, newDeck, _, reason, show)
  if oldDeck == newDeck and newDeck == bc.CardDeck.NoneDeck then
    BattleHandCardLogUtils.LogDeckChangeUI(self, cards, oldDeck, newDeck, reason, show, "BlowUp")
    EventMgr.Instance.CardBlowUp:Dispatch(self.cardMgr.camp, cards)
    return
  end
  BattleHandCardLogUtils.LogDeckChangeUI(self, cards, oldDeck, newDeck, reason, show, "Apply")
  self:RefreshCardNum()
  self:DoCardChangeDeck(cards, oldDeck, newDeck, reason, show)
  self:ResetSiblingIndex()
end

function BattlePanelCardUI:DoCardChangeDeck(cards, oldDeck, newDeck, _, show)
  if oldDeck == newDeck and (newDeck == bc.CardDeck.DrawDeck or newDeck == bc.CardDeck.GraveyardDeck) then
    self:DoAddNewCard(cards)
    return
  end
  if newDeck ~= bc.CardDeck.HandDeck and oldDeck ~= bc.CardDeck.HandDeck then
    self:TryReplayCleanupLeftHandCards(cards, newDeck, show)
    if 1 == show and (newDeck == bc.CardDeck.DrawDeck or newDeck == bc.CardDeck.GraveyardDeck) then
      self:DoAddNewCard(cards)
    end
    return
  end
  if newDeck == bc.CardDeck.HandDeck then
    self:MoveCardToHand(oldDeck)
  else
    local hasRemovedFromMap = false
    if newDeck == bc.CardDeck.GraveyardDeck then
      self:MoveCardToGraveyard(cards, show)
      if show == CommonDefine.BattleCardDropShowType.Burn then
        hasRemovedFromMap = true
      end
    elseif newDeck == bc.CardDeck.DrawDeck then
      self:MoveCardToGraveyard(cards, show)
      if show == CommonDefine.BattleCardDropShowType.Burn then
        hasRemovedFromMap = true
      end
    elseif newDeck == bc.CardDeck.UsingDeck then
      if bg.isReplay then
        self:SetCardsAnimState(cards, CommonDefine.CardAnim.CardRecordUse, function()
          if not self.ui or IsNil(self.ui.uiNode) then
            return
          end
          bg.battleRender:PerformWithDelay(0.03, function()
            self:SetCardsAnimState(cards, CommonDefine.CardAnim.CardDisappear)
          end, self)
        end)
      else
        self:SetCardsAnimState(cards, CommonDefine.CardAnim.CardDisappear)
      end
    elseif newDeck == bc.CardDeck.ConsumedDeck then
      self:SetCardsAnimState(cards, CommonDefine.CardAnim.CardConsume)
    elseif newDeck == bc.CardDeck.SwallowDeck then
      self:SetCardsAnimState(cards, CommonDefine.CardAnim.CardConsume)
    elseif oldDeck == bc.CardDeck.HandDeck then
      self:SetCardsAnimState(cards, CommonDefine.CardAnim.CardDisappear)
    end
    local isBackToPool = false
    if not hasRemovedFromMap then
      self:RemoveCards(cards, isBackToPool)
    end
    self:CheckRecycleDetachedCardItems()
    if bg.isReplay then
      self:CheckResetHandCard()
    end
  end
end

function BattlePanelCardUI:SetCardsAnimState(cards, animState, ...)
  for _, card in ipairs(cards) do
    local cardItem = self.cardItemMap[card]
    if not cardItem and bg.isReplay then
      cardItem = self.cardLifecycle:FindByUid(card.uid)
    end
    self:SetCardAnimState(cardItem, animState, ...)
  end
end

function BattlePanelCardUI:SetCardAnimState(cardItem, animState, ...)
  if not cardItem then
    return
  end
  if IsNil(cardItem.rootRectTransform) and bg.isReplay then
    local cardData = cardItem.card and cardItem.card.value
    local cardUid = cardData and cardData.uid or cardItem:GetUid()
    if cardItem.binder then
      cardItem.binder:teardown()
    end
    if cardUid then
      cardItem = self:GetCardItemByUid(cardUid, true)
    end
    if not cardItem or IsNil(cardItem.rootRectTransform) then
      local callback = select(1, ...)
      if callback then
        callback()
      end
      return
    end
  end
  if not self.cardLifecycle:CanPlayAnim(cardItem, animState) then
    local callback = select(1, ...)
    if callback then
      callback()
    end
    return
  end
  cardItem:GotoState(animState, ...)
  if bg.isPVP then
    self:SyncCardAnimState(cardItem:GetUid(), animState, ...)
  end
end

function BattlePanelCardUI:SyncCardAnimState(cardUid, animState, ...)
  if not cardUid then
    return
  end
  if not CommonDefine.CardManualAnim[animState] then
    return
  end
  if bg.isPVE or self.camp ~= bg.battleDataCenter:GetMyCamp() then
    return
  end
  bg.battleRender:SyncAction(BattleRenderEvent.CardInteract, {
    cardUid = cardUid,
    camp = self.camp,
    animState = animState
  })
end

function BattlePanelCardUI:OnReceiveCardInteract(cardUid, animState)
  if bg.isReplay and (animState == CardAnim.CardDrag or animState == CardAnim.CardForceUse) then
    return
  end
  local cardItem = self:GetCardItemByUid(cardUid)
  local displayStateMap = {
    [CardAnim.CardDisplay] = CardAnim.CardOtherDisplay,
    [CardAnim.CardDrag] = CardAnim.CardOtherDrag
  }
  animState = displayStateMap[animState] or animState
  if cardItem then
    cardItem:GotoState(animState)
  end
end

function BattlePanelCardUI:IsInAnimState(cardItem, animState)
  do return cardItem.IsInState, cardItem end
  return cardItem.IsInState, cardItem, animState
end

function BattlePanelCardUI:RebuildCardItemCache()
  self.cardItemSet = {}
  self.handIndexCardItemMap = {}
  for _, cardItem in pairs(self.cardItemMap) do
    self:UpdateCardItemCache(cardItem)
  end
end

function BattlePanelCardUI:UpdateCardItemCache(cardItem)
  if not cardItem then
    return
  end
  self.cardItemSet[cardItem] = true
  local handIndex = cardItem:GetHandIndex()
  for cacheIndex, cacheItem in pairs(self.handIndexCardItemMap) do
    if cacheItem == cardItem and cacheIndex ~= handIndex then
      self.handIndexCardItemMap[cacheIndex] = nil
    end
  end
  if handIndex then
    self.handIndexCardItemMap[handIndex] = cardItem
  end
end

function BattlePanelCardUI:RemoveCardItemCache(cardItem)
  if not cardItem then
    return
  end
  self.cardItemSet[cardItem] = nil
  for cacheIndex, cacheItem in pairs(self.handIndexCardItemMap) do
    if cacheItem == cardItem then
      self.handIndexCardItemMap[cacheIndex] = nil
    end
  end
end

function BattlePanelCardUI:IsInHandMap(cardItem)
  if not cardItem then
    return false
  end
  if self.cardItemSet[cardItem] then
    return true
  end
  for _, item in pairs(self.cardItemMap) do
    if item == cardItem then
      self:UpdateCardItemCache(cardItem)
      return true
    end
  end
  return false
end

function BattlePanelCardUI:IsInCardItemMap(cardItem)
  if not cardItem then
    return false
  end
  for _, item in pairs(self.cardItemMap) do
    if item == cardItem then
      return true
    end
  end
  local cardData = cardItem.card and cardItem.card.value
  if cardData and self.cardItemMap[cardData] == cardItem then
    return true
  end
  return false
end

function BattlePanelCardUI:MarkDetachAnimCardItem(cardItem)
  self.cardLifecycle:MarkDetachAnim(cardItem)
end

function BattlePanelCardUI:ClearDetachAnimCardItem(cardItem)
  self.cardLifecycle:ClearDetachAnim(cardItem)
end

function BattlePanelCardUI:IsOrphanPoolCardItem(cardItem)
  do return self.cardLifecycle.IsOrphan, self.cardLifecycle end
  return self.cardLifecycle.IsOrphan, self.cardLifecycle, cardItem
end

function BattlePanelCardUI:TryRecycleOrphanPoolCardByUid(cardUid)
  self.cardLifecycle:TryRecycleOrphanByUid(cardUid)
end

function BattlePanelCardUI:GetCardItemInPoolByUid(cardUid)
  do return self.cardLifecycle.GetInPoolByUid, self.cardLifecycle end
  return self.cardLifecycle.GetInPoolByUid, self.cardLifecycle, cardUid
end

function BattlePanelCardUI:FindCardItemByUid(cardUid)
  do return self.cardLifecycle.FindByUid, self.cardLifecycle end
  return self.cardLifecycle.FindByUid, self.cardLifecycle, cardUid
end

function BattlePanelCardUI:IsCardItemInMap(cardItem)
  do return self.cardLifecycle.IsInMap, self.cardLifecycle end
  return self.cardLifecycle.IsInMap, self.cardLifecycle, cardItem
end

function BattlePanelCardUI:IsHandReturnAnimState(animState)
  do return self.cardLifecycle.IsHandReturnAnim, self.cardLifecycle end
  return self.cardLifecycle.IsHandReturnAnim, self.cardLifecycle, animState
end

function BattlePanelCardUI:ClearPutbackCardItemByUid(cardUid)
  self.cardLifecycle:ClearPutbackByUid(cardUid)
end

function BattlePanelCardUI:ClearUseCardStateByUid(cardUid)
  self.cardLifecycle:ClearUseCardStateByUid(cardUid)
end

function BattlePanelCardUI:ForceRecycleDetachedCardItem(cardItem)
  self.cardLifecycle:ForceRecycle(cardItem)
end

function BattlePanelCardUI:IsReplayPvpSelectInitStage()
  if not bg.isReplay then
    return false
  end
  if self.isPVPSelecting.value then
    return true
  end
  return UIManager.Instance:GetWindow(Urls.PvPSelectInitCardPanel) ~= nil
end

function BattlePanelCardUI:CheckRecycleDetachedCardItems()
  if self:IsReplayPvpSelectInitStage() then
    return
  end
  self.cardLifecycle:SweepOrphans()
end

function BattlePanelCardUI:IsUsingCardItem(cardItem)
  if not cardItem then
    return false
  end
  local uid = cardItem:GetUid()
  return uid and self.usingCardUidMap and self.usingCardUidMap[uid] or false
end

function BattlePanelCardUI:IsHaveCardInHand()
  for cardData, _ in pairs(self.cardItemMap) do
    if cardData.deck == bc.CardDeck.HandDeck then
      return true
    end
  end
end

function BattlePanelCardUI:ExitHandCardAnimState(exitState)
  local handCardDataList = self.cardMgr:GetHandCardList()
  for index, cardData in ipairs(handCardDataList) do
    local cardItem = self.cardItemMap[cardData]
    if cardItem then
      cardItem:ExitState(exitState)
    end
  end
end

function BattlePanelCardUI:UpdateCardDragState(cardItem, pos, isUseTween)
  if cardItem then
    local isInDrag = cardItem:IsInState(CardAnim.CardDrag)
    if isInDrag then
      cardItem:UpdateState(CardAnim.CardDrag, pos, isUseTween)
    else
      self:SetCardAnimState(cardItem, CardAnim.CardDrag, pos, isUseTween)
    end
  end
end

function BattlePanelCardUI:RemoveCards(cards, isDispose)
  self.cardLifecycle:RemoveCards(cards, isDispose)
end

function BattlePanelCardUI:FreeCardItem(cardItem, isForce)
  self.cardLifecycle:FreeCardItem(cardItem, isForce)
end

function BattlePanelCardUI:CheckResetHandCard()
  if self.isPVPSelecting.value or not bg.battleDataCenter then
    return
  end
  if self:IsReplayPvpSelectInitStage() then
    return
  end
  local isNeedRelayout = false
  local handCardMap = self.cardMgr:GetCardMapByDeck(CardDeck.HandDeck)
  local removeCards = {}
  for cardData, cardItem in pairs(self.cardItemMap) do
    if not self:IsUsingCardItem(cardItem) then
      local uid = cardItem.card.value and cardItem.card.value.uid
      local isInNoState = not cardItem:IsInAnyAnimState()
      local isSelectInit = cardData.deck == bc.CardDeck.SelectInitDeck
      if isSelectInit then
        return
      end
      if uid then
        if not handCardMap[uid] then
          if not bg.isReplay or not cardItem:IsInAnyAnimState() then
            table.insert(removeCards, cardData)
          end
        elseif isInNoState and not isNeedRelayout and cardItem:GetHandIndex() then
          local pos = self.sector:GetSectionPoint(cardItem:GetHandIndex())
          local curPos = cardItem:GetPos()
          local deltaX = pos.x - curPos.x
          if deltaX > 0.01 or deltaX < -0.01 then
            isNeedRelayout = true
          end
        end
      end
    end
  end
  if #removeCards > 0 then
    BattleHandCardLogUtils.LogStaleHandUI(self, removeCards)
    self:RemoveCards(removeCards, not bg.isReplay)
  end
  if isNeedRelayout then
    self:DelayRelayoutHandCard()
  end
  self:CheckRecycleDetachedCardItems()
  self:CheckLoseCards()
end

function BattlePanelCardUI:DelayRelayoutHandCard(delayTime)
  if not self.delayRelayoutTimer then
    self.delayRelayoutTimer = bg.battleRender:PerformWithDelay(delayTime or 0.1, System.fn(self, self.RelayoutHandCard), self)
  end
end

local exceptMap = {
  [CommonDefine.CardAnim.CardRelayout] = true,
  [CommonDefine.CardAnim.CardChange] = true
}

function BattlePanelCardUI:RelayoutHandCard()
  self.delayRelayoutTimer = nil
  if self:IsForbidRelayoutAndResibling() then
    return
  end
  local handCardDataList = self.cardMgr:GetHandCardList()
  for index, cardData in ipairs(handCardDataList) do
    local cardItem = self.cardItemMap[cardData]
    if cardItem then
      cardItem:SetHandIndex(index)
      cardItem.gestureCallbacks = self:GetCardTouchFuncs()
      cardItem:SetClickable(true)
    end
  end
  self:RebuildCardItemCache()
  self.sector:SetSectionCount(#handCardDataList)
  for _, cardItem in pairs(self.cardItemMap) do
    if self._previewCard and self._previewCard == cardItem then
    elseif self.checkCard and self.checkCard == cardItem then
    elseif self:IsUsingCardItem(cardItem) then
    elseif not cardItem:IsInAnyAnimState(exceptMap) then
      self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardRelayout)
    end
  end
  self:ResetSiblingIndex()
end

function BattlePanelCardUI:IsForbidRelayoutAndResibling()
  if self.isPVPSelecting.value then
    return true
  end
  for _, cardItem in pairs(self.cardItemMap) do
    if self:IsInAnimState(cardItem, CardAnim.CardDropFadeAway) then
      return true
    end
    if self:IsInAnimState(cardItem, CardAnim.CardDropBurn) then
      return true
    end
    if self:IsInAnimState(cardItem, CardAnim.CardDropBurnPVP) then
      return true
    end
    if self:IsInAnimState(cardItem, CardAnim.CardDrop) then
      return true
    end
    if self:IsInAnimState(cardItem, CardAnim.CardConsume) then
      return true
    end
    if self:IsInAnimState(cardItem, CardAnim.CardBlessingUse) then
      return true
    end
  end
end

function BattlePanelCardUI:ResetSiblingIndex()
  if self:IsForbidRelayoutAndResibling() then
    return
  end
  local handCardDataList = self.cardMgr:GetHandCardList(true)
  for index, cardData in ipairs(handCardDataList) do
    local cardItem = self.cardItemMap[cardData]
    if cardItem and not IsNil(cardItem.rootRectTransform) and not self:IsInAnimState(cardItem, CardAnim.CardDrag) and not self:IsUsingCardItem(cardItem) then
      cardItem.rootRectTransform:SetSiblingIndex(index - 1)
    end
  end
end

function BattlePanelCardUI:CheckLoseCards()
  self._cardWrongTimes = self._cardWrongTimes or 0
  local handCardDataList = self.cardMgr:GetHandCardList()
  local isCardWrong = false
  for index, cardData in ipairs(handCardDataList) do
    local cardItem = self.cardItemMap[cardData]
    if not cardItem then
      isCardWrong = true
    end
    if cardItem and IsNil(cardItem.rootRectTransform) then
      isCardWrong = true
      if not bg.isReplay then
        self:RemoveCards({cardData}, true)
      end
    end
  end
  if isCardWrong then
    self._cardWrongTimes = self._cardWrongTimes + 1
    BattleHandCardLogUtils.LogMissingCardItems(self, handCardDataList)
    BattleHandCardLogUtils.LogAnomaly("CheckLoseCards", self, string.format("wrongTimes=%d", self._cardWrongTimes))
  else
    self._cardWrongTimes = 0
  end
  if self._cardWrongTimes > 10 then
    BattleHandCardLogUtils.LogRecoverHandUI(self, handCardDataList)
    self._cardWrongTimes = 0
    for index, cardData in ipairs(handCardDataList) do
      local cardItem = self.cardItemMap[cardData]
      if not cardItem then
        cardItem = self:CreateCardItem(cardData.uid, nil, true)
        if cardItem then
          cardItem:SetHandIndex(index)
          self:UpdateCardItemCache(cardItem)
          self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardReset)
        end
      end
    end
    self:ResetSiblingIndex()
  end
end

function BattlePanelCardUI:MoveCardToHand(oldDeck)
  local cardList = self.cardMgr:GetHandCardList()
  local drawCount = 0
  for index, card in ipairs(cardList) do
    local cardItem = self.cardItemMap[card]
    if not cardItem then
      cardItem = self:GetNewCardItem()
      cardItem:SetIsNeedHighDescMode(true)
      cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
      cardItem:Init(card, self.uiDelegate:GetCardContent().transform, self:GetCardTouchFuncs())
      self.cardItemMap[card] = cardItem
      cardItem:SetHandIndex(index)
      self:UpdateCardItemCache(cardItem)
      local isConsumeUseBackCard = self._consumeUseBackUidMap and self._consumeUseBackUidMap[card.uid]
      if isConsumeUseBackCard then
        self._consumeUseBackUidMap[card.uid] = nil
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardReset)
      elseif oldDeck == CardDeck.DimensionDeck then
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardFromDimension)
      elseif oldDeck == CardDeck.UsingDeck then
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardUseBack, drawCount)
      else
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardDraw, drawCount)
        drawCount = drawCount + 1
      end
    else
      cardItem:SetHandIndex(index)
      self:UpdateCardItemCache(cardItem)
      if self:IsInAnimState(cardItem, CommonDefine.CardAnim.CardDraw) then
        cardItem:UpdateState(CommonDefine.CardAnim.CardDraw, drawCount)
        drawCount = drawCount + 1
      else
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardRelayout)
      end
    end
  end
  if drawCount > 0 then
    bg.SendBattleEvent(rc.BattleEvent.MoveCardToHand)
  end
end

local cardDropShowTypeAnim = {
  [CommonDefine.BattleCardDropShowType.Normal] = CommonDefine.CardAnim.CardDrop,
  [CommonDefine.BattleCardDropShowType.Fade] = CommonDefine.CardAnim.CardDropFadeAway,
  [CommonDefine.BattleCardDropShowType.Burn] = CommonDefine.CardAnim.CardDropBurn
}
local cardDropShowTypeAnimPVP = {
  [CommonDefine.BattleCardDropShowType.Normal] = CommonDefine.CardAnim.CardDrop,
  [CommonDefine.BattleCardDropShowType.Fade] = CommonDefine.CardAnim.CardDropFadeAway,
  [CommonDefine.BattleCardDropShowType.Burn] = CommonDefine.CardAnim.CardDropBurnPVP
}

function BattlePanelCardUI:MoveCardToGraveyard(cards, showType)
  local dropList = {}
  local cardMap = {}
  for _, card in ipairs(cards) do
    local cardItem = self.cardItemMap[card] or self:GetCardItemByUid(card.uid)
    if cardItem then
      table.insert(dropList, cardItem)
      cardMap[cardItem] = card
    elseif bg.isReplay then
      self:TryRecycleOrphanPoolCardByUid(card.uid)
    end
  end
  self:SortByHandIndex(dropList)
  local isBurn = false
  if showType == CommonDefine.BattleCardDropShowType.Burn then
    isBurn = true
  end
  local anim
  if bg.isPVE then
    anim = showType and cardDropShowTypeAnim[showType] or cd.CardAnim.CardDrop
  else
    anim = showType and cardDropShowTypeAnimPVP[showType] or cd.CardAnim.CardDrop
  end
  for index, cardItem in ipairs(dropList) do
    if isBurn then
      cardItem:SetIsNeedHighDescMode(false)
      self:RemoveCards({
        cardMap[cardItem]
      }, true)
    else
      self:SetCardAnimState(cardItem, anim, index)
    end
    if self.checkCard == cardItem then
      self:ResetCheckCard()
    end
  end
  if isBurn then
    EventMgr.Instance.CardBlowUp:Dispatch(self.camp, cards, true)
  end
  self:DelayRelayoutHandCard(1.1)
end

function BattlePanelCardUI:SortByHandIndex(cardList)
  table.sort(cardList, function(a, b)
    local handIndexA = a:GetHandIndex()
    local handIndexB = b:GetHandIndex()
    if handIndexA and handIndexB and handIndexA ~= handIndexB then
      return handIndexA < handIndexB
    end
    return a:GetUid() < b:GetUid()
  end)
end

local function ScreenToLocalPos(screenPos, parentTransform, transform)
  local rectTransformUtility = CS.UnityEngine.RectTransformUtility
  local _, localPos = rectTransformUtility.ScreenPointToLocalPointInRectangle(parentTransform, screenPos, bg.uiCamera)
  local parentPivot = parentTransform.pivot
  local pivot = transform.pivot
  local deltaX = (parentPivot.x - pivot.x) * parentTransform.sizeDelta.x
  local deltaY = (parentPivot.y - pivot.y) * parentTransform.sizeDelta.y
  localPos.x = localPos.x + deltaX
  localPos.y = localPos.y + deltaY
  return localPos
end

function BattlePanelCardUI:OnChangeBoutPhase(data)
  if self:IsMyCamp() and data.newPhase == bc.BoutPhase.End then
    self:PutBackPreviewCard()
  end
  if bg.isPVP and data.newPhase == bc.BoutPhase.End then
    UIManager.Instance:CloseByUrl(Urls.DeckCardSelectPanel)
    for cardData, cardItem in pairs(self.cardItemMap) do
      if self:IsUsingCardItem(cardItem) then
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardUseBack)
      end
    end
  end
end

function BattlePanelCardUI:OnChangeCardId(data)
  local cardUid = data.cardUid or data.uid
  local isPlayEffect = data.isPlayEffect
  local cardItem = self:GetCardItemByUid(cardUid)
  
  local function changeUidFunc()
    if cardItem then
      cardItem:SetHandIndex(self:GetCardIndex(cardUid))
      self:UpdateCardItemCache(cardItem)
    end
    local cardClient = self.cardMgr:GetCardByUid(cardUid)
    if cardClient then
      cardClient:ChangeCardId(data)
      if cardClient.deck == CardDeck.HandDeck then
        self:DelayRelayoutHandCard()
      end
    end
  end
  
  if cardItem and isPlayEffect then
    self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardChange, changeUidFunc)
  else
    changeUidFunc()
  end
end

function BattlePanelCardUI:OnPlayCardVFX(data)
  local cardUids = data.cardUids
  for _, cardUid in ipairs(cardUids) do
    local cardItem = self:GetCardItemByUid(cardUid)
    
    local function playCardVFXFunc()
      local cardClient = self.cardMgr:GetCardByUid(cardUid)
      if cardClient then
        cardClient:ChangeCardBg(cardItem, data.vfx)
      end
    end
    
    playCardVFXFunc()
  end
end

function BattlePanelCardUI:OnAddNewCard()
  local cardList = self.cardMgr:GetCardListByDeck(bc.CardDeck.DrawDeck)
  self.deckCardNum.value = #cardList
  local graveyardNum = self.cardMgr:GetCardListByDeck(bc.CardDeck.GraveyardDeck)
  self.graveyardNum.value = #graveyardNum
end

function BattlePanelCardUI:DelayAddNewCard(cards)
  local deckSnapshot = {}
  for _, card in ipairs(cards) do
    deckSnapshot[card.uid] = card.deck
  end
  bg.battleRender:PerformWithDelay(0.01, function()
    self:AddNewCard(cards, deckSnapshot)
  end, self)
end

function BattlePanelCardUI:AddNewCard(cards, deckSnapshot)
  if not self._newCardList then
    self._newCardList = {}
    self.binder:BindToRaw(function(_, isVisble)
      if isVisble then
        for _, entry in ipairs(self._newCardList) do
          self:DoAddNewCard(entry.cards, entry.deckSnapshot)
        end
        self._newCardList = {}
      end
      return self._newCardList
    end, function()
      do return bg.battlePanel.GetUIVisible end
      return bg.battlePanel.GetUIVisible, bg.battlePanel
    end)
  end
  if bg.battlePanel:GetUIVisible() then
    self:DoAddNewCard(cards, deckSnapshot)
  else
    table.insert(self._newCardList, {cards = cards, deckSnapshot = deckSnapshot})
  end
end

function BattlePanelCardUI:DoAddNewCard(cards, deckSnapshot)
  self:RefreshCardNum()
  local embryoCardTid = DT.BattleApi.EmbryoCard.Data
  for index, card in ipairs(cards) do
    local deck = card.deck
    if deckSnapshot and deckSnapshot[card.uid] and deckSnapshot[card.uid] ~= deck then
    else
      local isHandCard = deck == CardDeck.HandDeck
      local cardItem = self.cardItemMap[card]
      if not cardItem then
        cardItem = self:GetNewCardItem()
        cardItem:SetHighDescPos()
      end
      if isHandCard then
        cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
        cardItem:Init(card, self.deckRectTransform, self:GetCardTouchFuncs())
        cardItem:SetHandIndex(self:GetCardIndex(card.uid))
        self.cardItemMap[card] = cardItem
        self:UpdateCardItemCache(cardItem)
      else
        cardItem:Init(card, self.deckRectTransform, {})
      end
      if card.configData.ID == embryoCardTid then
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardEmbryoNew)
      elseif deck == CardDeck.HandDeck then
        self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardInsert)
      elseif deck == CardDeck.DrawDeck or deck == CardDeck.GraveyardDeck then
        cardItem:SetIsNeedHighDescMode(false)
        self:CardFlyToDrawDeck(card, cardItem, deck)
      else
        self:FreeCardItem(cardItem)
      end
    end
  end
  self:ResetSiblingIndex()
end

function BattlePanelCardUI:GetEmbryoBornEffect()
  local effect
  self.embryoBornEffects = self.embryoBornEffects or {}
  for i = 1, #self.embryoBornEffects do
    if self.embryoBornEffects[i]:IsFree() then
      effect = self.embryoBornEffects[i]
      break
    end
  end
  if not effect then
    effect = DbgEventEmbryoBornEffect(self.binder, self)
    table.insert(self.embryoBornEffects, effect)
  end
  return effect
end

function BattlePanelCardUI:GetEmbryoSwallowEffect()
  local effect
  self.swallowEmbryoEffects = self.swallowEmbryoEffects or {}
  for i = 1, #self.swallowEmbryoEffects do
    if self.swallowEmbryoEffects[i]:IsFree() then
      effect = self.swallowEmbryoEffects[i]
      break
    end
  end
  if not effect then
    effect = DbgEventSwallowEmbryoEffect(self.binder, self)
    table.insert(self.swallowEmbryoEffects, effect)
  end
  return effect
end

function BattlePanelCardUI:StartSwallowEmbryoCards(cardList)
  for i = 1, #cardList do
    local cardItem = self:GetCardItemByUid(cardList[i])
    self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardEmbryoSwallow)
  end
end

function BattlePanelCardUI:TestNewEmbryoCardsAnimation()
  for k, v in pairs(self.cardItemMap) do
    self:SetCardAnimState(v, CommonDefine.CardAnim.CardEmbryoNew)
  end
end

function BattlePanelCardUI:TestSwallowEmbryoCardsAnimation()
  for k, v in pairs(self.cardItemMap) do
    self:SetCardAnimState(v, CommonDefine.CardAnim.CardEmbryoSwallow)
  end
end

function BattlePanelCardUI:OnCardBlowUp(camp, cards)
  for _, cardData in ipairs(cards) do
    local cardItem
    if bg.isReplay then
      cardItem = self.cardItemMap[cardData] or self:FindCardItemByUid(cardData.uid)
      cardItem = cardItem or self:CreateCardItem(cardData, nil, false)
      if cardItem and self:IsCardItemInMap(cardItem) then
        self:RemoveCards({cardData}, false)
      end
    else
      cardItem = self:CreateCardItem(cardData, nil, false)
      self:RemoveCards({cardData}, false)
    end
    self:CardFlyToDrawDeck(cardData, cardItem, bc.CardDeck.NoneDeck)
  end
end

function BattlePanelCardUI:CardFlyToDrawDeck(card, cardItem, deck)
  if bg.isReplay then
    if not self.battlePanel:IsRendering() then
      if cardItem and not self:IsCardItemInMap(cardItem) then
        self:ForceRecycleDetachedCardItem(cardItem)
      end
      return
    end
    self._cachedCardFlyUidMap = self._cachedCardFlyUidMap or {}
    if self._cachedCardFlyUidMap[card.uid] then
      if cardItem and not self:IsCardItemInMap(cardItem) then
        self:ForceRecycleDetachedCardItem(cardItem)
      end
      return
    end
    self._cachedCardFlyUidMap[card.uid] = true
  end
  local cardWidth = 320
  local moveY = 120
  local changeScale = false
  local destGo = self.uiDelegate:GetDrawDeckBtn()
  if deck == CardDeck.GraveyardDeck then
    destGo = self.uiDelegate:GetGraveyardDeckBtn()
  end
  if bg.isPVP and card.awaker.camp ~= self.myCamp then
    cardWidth = ENEMY_CARD_RATE * cardWidth
    moveY = 240
    changeScale = true
    destGo = self.uiDelegate.ui.Card_Content_Enemy
  end
  if not destGo then
    return
  end
  local cardTransform = cardItem.rootRectTransform
  local destWorldPos = destGo.transform.position
  local destLocalPos = cardTransform.parent:InverseTransformPoint(destWorldPos)
  self.insertingCards = self.insertingCards or {}
  table.insert(self.insertingCards, cardItem)
  local insertingCount = #self.insertingCards
  local startX = -insertingCount * cardWidth / 2 + cardWidth / 2
  for index, insertCard in ipairs(self.insertingCards) do
    local transForm = insertCard.rootRectTransform
    local cardX = startX + (index - 1) * cardWidth
    if index == #self.insertingCards then
      transForm.localPosition = Vector3(cardX, 600, 0)
    elseif not insertCard._isMiddle then
      if insertCard._shiftXTween then
        insertCard._shiftXTween:Kill()
      end
      insertCard._shiftXTween = transForm:DOLocalMoveX(cardX, 0.2)
    end
  end
  if bg.isPVE then
    local awaiterStopAll = Awaiter.Get()
    EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiterStopAll, "CardFlyingStopAll", nil, false)
    bg.battleRender:PerformWithDelay(1, function()
      awaiterStopAll:SetCompleted()
    end, self)
  end
  local animAwaiter = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(animAwaiter, "CardFlying")
  local flyAnim = bg.isPVE and "Item_Battle_Card_2_vx" or "Item_Pvp_Battle_Card_1_vx"
  if deck == CardDeck.NoneDeck then
    flyAnim = changeScale and "Item_Battle_Card_2_vx_enemy" or "Item_Battle_Card_2_vx"
  end
  bg.SendBattleEvent(rc.BattleEvent.InsertCard)
  bg.battleRender:PerformWithDelay(#self.insertingCards * 0.05, function()
    if not (cardItem and cardItem.ui) or IsNil(cardItem.ui.uiNode) then
      return
    end
    cardItem:PlayInsertAnim(flyAnim, function()
      cardItem._isMiddle = false
      cardTransform:DOLocalMoveY(cardTransform.localPosition.y + moveY, 0.1)
      if deck == bc.CardDeck.NoneDeck then
        bg.battleRender:PerformWithDelay(1, function()
          table.delete(self.insertingCards, cardItem)
          if not (cardItem and cardItem.ui) or IsNil(cardItem.ui.uiNode) then
            return
          end
          cardItem:StopAnim()
          self:SetCardAnimState(cardItem, cd.CardAnim.CardDisappear, true)
        end, cardItem)
      end
    end, function()
      if not cardItem or not cardItem.ui then
        return
      end
      if deck == bc.CardDeck.NoneDeck then
        return
      end
      cardItem._isMiddle = true
      if card._shiftXTween then
        card._shiftXTween:Kill()
        card._shiftXTween = nil
      end
      if cardItem.ui then
        local sequence = DOTween.Sequence(self)
        local trailRender
        if cardItem.ui.Root_Effect_Trail then
          trailRender = cardItem.ui.Root_Effect_Trail:GetComponentInChildren(typeof(TrailRenderer))
          trailRender.enabled = true
          sequence:Insert(0, DOTween.To(function()
            return trailRender.widthMultiplier
          end, function(v)
            trailRender.widthMultiplier = v
          end, 0.5, 0.1, self))
        end
        sequence:Append(cardTransform:DOLocalMove(destLocalPos, 0.35):SetEase(Tweening.Ease.OutSine))
        sequence:AppendCallback(function()
          table.delete(self.insertingCards, cardItem)
          if trailRender then
            trailRender.enabled = false
          end
          cardItem._isMiddle = false
          sequence:Kill()
          self.cardTweeners[cardItem] = nil
          cardTransform.localRotation = Quaternion.identity
          self:FreeCardItem(cardItem)
        end)
        self.cardTweeners[cardItem] = sequence
        animAwaiter:SetCompleted()
      else
        self:FreeCardItem(cardItem)
      end
    end)
  end, cardItem)
end

function BattlePanelCardUI:CanUseCard(card)
  if self.opMode.value == rc.OpMode.Inspect or self.opMode.value == rc.OpMode.SelectHandCard then
    print("[UseCardFail]" .. self.opMode.value)
    return false
  end
  local boutMgr = bg.battleRender.boutMgr
  local cardItem = self:GetCardItemByUid(card.uid)
  if not cardItem then
    return false
  end
  if not bg.battleRender:CanUseCommand(BattleCommand.lg_UseCard) then
    print("[UseCardFail] Can not use lg_UseCard")
    return false
  end
  if boutMgr:GetPhase() == bc.BoutPhase.None or boutMgr:GetPhase() == bc.BoutPhase.End then
    print("[UseCardFail] bout phase is none or end")
    return false
  end
  local myCamp = bg.battleDataCenter:GetMyCamp()
  if bg.battleDataCenter:GetRealCamp() ~= myCamp then
    print("[UseCardFail] not my camp")
    return false
  end
  local battlePanel = bg.battlePanel
  if not battlePanel or battlePanel.isClickedBtnBout then
    print("[UseCardFail] clicked btn end but not response")
    return false
  end
  local tipTid
  if self.cardMgr:GetCardRealDeck(card.uid) ~= CardDeck.HandDeck then
    tipTid = 10625
  else
    local ret, reason = card:CanUse()
    if not ret then
      local match = {
        [bc.CardFailedReason.NotInHand] = 10155,
        [bc.CardFailedReason.Useless] = 10156,
        [bc.CardFailedReason.NoSkill] = 10157,
        [bc.CardFailedReason.LimitUse] = 10158,
        [bc.CardFailedReason.NoEnergy] = 10159,
        [bc.CardFailedReason.NoAwaker] = 10160
      }
      tipTid = match[reason] or 0
      if 0 == tipTid and type(reason) == "string" then
        cardItem:ShowCannotReason(reason)
        return false
      end
    end
  end
  if tipTid then
    local tipsCfg = bg.DT.TipsType[tipTid]
    if tipsCfg and tipsCfg.Desc then
      cardItem:ShowCannotReason(LT.Text(tipsCfg.Desc))
    end
    return false
  end
  local cardClient = cardItem.card.value
  if cardClient and not cardClient:CheckUsable() then
    return false
  end
  return true
end

function BattlePanelCardUI:UseCard(cardItem)
  local card = cardItem.card.value
  local cardUid = card.uid
  self.usingCardUidMap = self.usingCardUidMap or {}
  self.usingCardUidMap[cardUid] = true
  self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardUse)
  if self.checkCard == cardItem then
    self.touchDownX = nil
    self.touchDownY = nil
    self:CheckCardInit(nil)
  end
  local useFailTime = 3
  local putbackTicker = bg.battleRender:PerformWithDelay(useFailTime, function()
    local cardItemRef = self:FindCardItemByUid(cardUid)
    if card.deck == bc.CardDeck.HandDeck and cardItemRef and self.cardItemMap[card] then
      self:SetCardAnimState(self.cardItemMap[card], CommonDefine.CardAnim.CardDisplayBack)
      self:DelayRelayoutHandCard()
    elseif cardItemRef and not self.cardItemMap[card] then
      self:ForceRecycleDetachedCardItem(cardItemRef)
    end
    if self.usingCardUidMap then
      self.usingCardUidMap[cardUid] = nil
    end
    if cardItemRef then
      self.putbackTicks[cardItemRef] = nil
    end
  end, self)
  self.putbackTicks = self.putbackTicks or {}
  self:ClearPutbackCardItem(cardItem)
  self.putbackTicks[cardItem] = putbackTicker
  AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Comfirm")
  BattleVoiceModel.Instance:ResetPvpPlayerThinking()
  local cmdTargetMode = bg.battleRender.cmdTargetMgr and bg.battleRender.cmdTargetMgr:GetModel() or bc.PVPTargetModel.Server
  local sendData = {
    cardUid = cardUid,
    camp = self.camp,
    playerId = bg.battleDataCenter:GetPlayerIdByCamp(self.camp)
  }
  local energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.energy)
  local baseEnergy = bg.battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.max_energy)
  if energy == baseEnergy then
    EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideCondBoutFirstCard, {
      bg.battleRender.battleTid,
      bg.battleRender.boutMgr:GetBoutNum()
    })
  end
  if cmdTargetMode == bc.PVPTargetModel.Server then
    bg.battleRender:SendCommand(BattleCommand.lg_UseCard, sendData)
  elseif cmdTargetMode == bc.PVPTargetModel.Client then
    bg.battleRender.cmdTargetMgr:OnParseCommond(BattleCommand.lg_UseCard, sendData)
    self:ClearPutbackCardItem(cardItem)
  end
end

function BattlePanelCardUI:OnPVPAwakerSelectCancel(skillConfigId)
  if SkillDataUtils.CheckIsUltiSkill(skillConfigId) then
    return
  end
  for cardData, cardItem in pairs(self.cardItemMap) do
    if self:IsUsingCardItem(cardItem) then
      self:ClearPutbackCardItem(cardItem)
      self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardUseBack)
    end
  end
  self.usingCardUidMap = {}
  self:DelayRelayoutHandCard()
end

function BattlePanelCardUI:OnPVPViewChange()
  self:RefreshCardNum()
  self:DelayRelayoutHandCard(0)
end

function BattlePanelCardUI:ClearPutbackCardItem(cardItem)
  local ticker = self.putbackTicks and self.putbackTicks[cardItem]
  if ticker then
    bg.battleRender:UnperformWithDelay(ticker)
  end
end

function BattlePanelCardUI:ChangeUseCardResultDeck(cardUid, oldDeck, newDeck)
  if not newDeck then
    return
  end
  self.cardMgr:ChangeCardListDeck({cardUid}, oldDeck, newDeck, false)
  if self._consumeUseBackUidMap then
    self._consumeUseBackUidMap[cardUid] = nil
  end
end

function BattlePanelCardUI:OnCommandResult(msgData)
  if self.camp ~= bg.battleDataCenter:GetMyCamp() then
    return
  end
  if msgData.msgId ~= BattleCommand.lg_UseCard then
    return
  end
  local card = self.cardMgr:GetCardByUid(msgData.cardUid)
  if not card then
    return
  end
  local cardItem = self:FindCardItemByUid(msgData.cardUid)
  local newDeck = msgData.newDeck
  local oldDeck = card.deck
  if not cardItem then
    self:ClearUseCardStateByUid(msgData.cardUid)
    if msgData.ret then
      if not (card.property:GetProperty(bc.CardProperty.consume) > 0) or newDeck ~= CardDeck.HandDeck then
        self:ChangeUseCardResultDeck(msgData.cardUid, oldDeck, newDeck)
      end
      self:DelayRelayoutHandCard()
    end
    self:CheckRecycleDetachedCardItems()
    return
  end
  self:ClearPutbackCardItem(cardItem)
  if msgData.ret then
    local isConsumeCard = card.property:GetProperty(bc.CardProperty.consume) > 0
    local isConsumeUseBackCard = isConsumeCard and newDeck == CardDeck.HandDeck
    local isInMap = self:IsCardItemInMap(cardItem)
    if isConsumeCard then
      self:RemoveCards({card})
    end
    if cardItem:ShouldPlayConsumeCardEffect() then
      if not isConsumeUseBackCard then
        cardItem:ShowEclipseEffect(function()
        end)
      else
        self._consumeUseBackUidMap = self._consumeUseBackUidMap or {}
        self._consumeUseBackUidMap[msgData.cardUid] = true
      end
    end
    if not isInMap and not isConsumeUseBackCard then
      self:ForceRecycleDetachedCardItem(cardItem)
    elseif isConsumeUseBackCard then
      self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardDisappear, false, function()
        self:ChangeUseCardResultDeck(msgData.cardUid, oldDeck, newDeck)
      end)
    else
      self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardDisappear)
      if newDeck == CardDeck.GraveyardDeck then
        self:FreeCardItem(cardItem, true)
      end
    end
    self:DelayRelayoutHandCard()
    EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.GuideBattleUseCard, bg.battleRender.battleTid)
    if self.usingCardUidMap then
      self.usingCardUidMap[msgData.cardUid] = nil
    end
  else
    if self:IsCardItemInMap(cardItem) then
      self:PutbackCard(cardItem)
    else
      self:ForceRecycleDetachedCardItem(cardItem)
    end
    if self.usingCardUidMap then
      self.usingCardUidMap[msgData.cardUid] = nil
    end
  end
  if not (msgData.ret and card.property:GetProperty(bc.CardProperty.consume) > 0) or newDeck ~= CardDeck.HandDeck then
    self:ChangeUseCardResultDeck(msgData.cardUid, oldDeck, newDeck)
  end
  self:CheckRecycleDetachedCardItems()
end

function BattlePanelCardUI:OnCardDisplayChange(data)
  print("OnCardDisplayChange", table.tostring(data))
  if not data or not data.cardUid then
    return
  end
  local card = self.cardMgr:GetCardByUid(data.cardUid)
  if not card then
    print("OnCardDisplayChange skip: card not found", data.cardUid)
    return
  end
  if self.camp ~= card.camp then
    print("OnCardDisplayChange skip: camp mismatch", self.camp, card.camp, data.cardUid)
    return
  end
  self.cardLifecycle:DestroyExistingByUid(data.cardUid)
  local cardItem = self:GetNewCardItem()
  if not cardItem or System.is(cardItem, BattleCardBackItem) then
    Logger.Warn("OnCardDisplayChange 创建展示卡失败", data.cardUid)
    return
  end
  card.config.isDisplay = true
  cardItem.isBlessingDisplay = true
  cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
  cardItem:Init(card, self.uiDelegate:GetCardContent().transform)
  cardItem:SetIsNeedHighDescMode(false)
  self:MarkDetachAnimCardItem(cardItem)
  self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardBlessingUse, data)
end

function BattlePanelCardUI:OnUseCard(cardUid, targetDeck)
  print("OnUseCard", cardUid, targetDeck)
end

function BattlePanelCardUI:DisplayUsingCard(cardClient)
  AudioManager.Instance:PostSoundEvent("Play_UI_Poker_PVP_Comfirm_En")
  cardClient.config.isDisplay = true
  local cardItem = self:GetNewCardItem()
  if System.is(cardItem, BattleCardBackItem) then
    return
  end
  cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
  cardItem:Init(cardClient, self.uiDelegate:GetCardContent().transform)
  cardItem:SetIsNeedHighDescMode(false)
  cardItem.ui.uiNode.transform.localPosition = Vector3(0, 700, 0)
  cardItem:PlayState("Item_Battle_Card_3_vx", function()
    cardClient.config.isDisplay = false
    cardItem.ui.uiNode.transform.localPosition = Vector3(-10000, 0, 0)
    self:FreeCardItem(cardItem)
  end)
end

function BattlePanelCardUI:PutbackCard(cardItem)
  if not cardItem then
    self:RelayoutHandCard()
    self:HideCardDetail()
    return
  end
  if not self:IsCardItemInMap(cardItem) then
    self:ForceRecycleDetachedCardItem(cardItem)
    self:RelayoutHandCard()
    self:HideCardDetail()
    return
  end
  self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardPutBack)
  self:RelayoutHandCard()
  self:HideCardDetail()
end

function BattlePanelCardUI:RefreshCardNum()
  local cardList = self.cardMgr:GetCardListByDeck(bc.CardDeck.DrawDeck)
  self.deckCardNum.value = #cardList
  local graveyardNum = self.cardMgr:GetCardListByDeck(bc.CardDeck.GraveyardDeck)
  self.graveyardNum.value = #graveyardNum
  local handList = self.cardMgr:GetCardListByDeck(bc.CardDeck.HandDeck)
  self.handCardNum.value = #handList
  self.sector:SetSectionCount(#handList)
  self:DelayRelayoutHandCard()
end

function BattlePanelCardUI:OnSelectCardEffect(data)
  if self.camp ~= bg.battleDataCenter:GetMyCamp() then
    return
  end
  if not data.showList then
    bg.battleRender:SetCurCommand(false)
    local resp = {
      effectUid = data.effectUid,
      selectCardTids = {}
    }
    bg.battleRender:SendCommand(BattleCommand.lg_SelectCard, resp)
    return
  end
  local showCards = {}
  for index, value in ipairs(data.showList) do
    table.insert(showCards, {
      uid = value.tid * -1 + index,
      configId = value.tid,
      level = value.level
    })
  end
  
  local function confirmCallback(uids)
    if not bg.battleRender:CanUseCommand(BattleCommand.lg_SelectCard) then
      return
    end
    self.opMode.value = rc.OpMode.Play
    bg.battleRender:SetCurCommand(false)
    local cardTids = {}
    for _, value in ipairs(showCards) do
      if table.findvalue(uids, value.uid) then
        table.insert(cardTids, value.configId)
      end
    end
    local resp = {
      effectUid = data.effectUid,
      selectCardTids = cardTids
    }
    bg.battleRender:SendCommand(BattleCommand.lg_SelectCard, resp)
  end
  
  local function closeCallback()
    bg.battleRender:SetCurCommand(false)
    local resp = {
      effectUid = data.effectUid,
      selectCardTids = {}
    }
    bg.battleRender:SendCommand(BattleCommand.lg_SelectCard, resp)
  end
  
  local title = string.format("选择一个效果")
  UIManager.Instance:Show(Urls.DbgBattleSelectCardsPanel, showCards, title, data.num, confirmCallback, closeCallback)
end

function BattlePanelCardUI:OnSelectCards(data)
  local cardList = {}
  for _, cardUid in ipairs(data.targetUids) do
    local card = self.cardMgr:GetCardByUid(cardUid)
    table.insert(cardList, card)
  end
  self.cardMgr:SortSelectCardList(cardList)
  if 0 == #cardList then
    self.opMode.value = rc.OpMode.Play
    bg.battleRender:SetCurCommand(false)
    local resp = {
      effectUid = data.effectUid,
      targetUids = {},
      selectType = data.targetSelectType
    }
    bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    return
  end
  
  local function onSelectComplete(cardUids)
    if not bg.battleRender:CanUseCommand(BattleCommand.lg_SelectTargets) then
      return
    end
    self.opMode.value = rc.OpMode.Play
    bg.battleRender:SetCurCommand(false)
    local resp = {
      effectUid = data.effectUid,
      targetUids = cardUids,
      selectType = data.targetSelectType
    }
    bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    UIManager.Instance:CloseByUrl(Urls.DeckCardSelectPanel)
  end
  
  local selectNum = math.min(data.selectNum, #cardList)
  local properties = {}
  properties.selectNum = selectNum
  properties.minNum = data.minNum
  properties.desc = data.desc and LT.Textf(data.desc, selectNum)
  properties.cancelable = data.cancelable
  properties.enchantTid = data.enchantTid
  self.opMode.value = rc.OpMode.Inspect
  properties.callback = onSelectComplete
  self:PutBackPreviewCard()
  UIManager.Instance:Reopen(Urls.DeckCardSelectPanel, cardList, properties)
end

function BattlePanelCardUI:OnSelectMoveCardResult(data)
  if self.camp ~= bg.battleDataCenter:GetMyCamp() then
    return
  end
  if self.opMode.value ~= rc.OpMode.SelectHandCard then
    return
  end
  if data == bc.BattleCardMoveResult.NoCard then
    Logger.Debug("没有可选卡牌！！！")
  else
    Logger.Debug("OnSelectMoveCards", table.tostring(data))
  end
end

BattlePanelCardUI.CardPosOffset = Vector2(0, 50)

function BattlePanelCardUI:ShowCardItemDetail(cardItem)
  if not (cardItem and cardItem.card) or not cardItem.card.value then
    return
  end
  local cardSectorPos = self:GetCardPosAndAngle(cardItem.card.value.uid)
  local cardWorldPos = self.deckRectTransform:TransformPoint(Vector3(cardSectorPos.x, cardSectorPos.y, 0))
  self:PutBackPreviewCard()
  self:ShowOrRefreshCardDetail(cardItem.card.value, cardWorldPos)
end

function BattlePanelCardUI:ShowCardItemPreview(cardItem)
  self:PutBackPreviewCard(true)
  self._previewCard = cardItem
  local cardSectorPos = self:GetCardPosAndAngle(cardItem.card.value.uid)
  local cardWorldPos = self.deckRectTransform:TransformPoint(Vector3(cardSectorPos.x, cardSectorPos.y, 0))
  if BattleCardShotcutDragDropMgr.Instance:GetDraggingCardItem() then
    BattleCardShotcutDragDropMgr.Instance:StopDragCard()
  end
  self:SetCardAnimState(self._previewCard, CommonDefine.CardAnim.CardDisplay)
  self._previewCardState = CommonDefine.CardCheck.CardDisplay
  local cardpreviewPanel = UIManager.Instance:GetWindow(Urls.BattleCardPreviewPanel)
  if cardpreviewPanel then
    cardpreviewPanel:UpdateBattleTouchPos(cardItem.card.value, cardWorldPos)
  else
    UIManager.Instance:Reopen(Urls.BattleCardPreviewPanel, cardItem.card.value, cardWorldPos)
  end
end

function BattlePanelCardUI:PutBackPreviewCard(withClosePanel)
  if not withClosePanel then
    UIManager.Instance:CloseByUrl(Urls.BattleCardPreviewPanel)
  end
  if self._previewCard and self._previewCardState == CommonDefine.CardCheck.CardDisplay and not self:IsUsingCardItem(self._previewCard) then
    self:SetCardAnimState(self._previewCard, CommonDefine.CardAnim.CardPutBack)
  end
  self._previewCard = nil
  self._previewCardState = CommonDefine.CardCheck.None
end

function BattlePanelCardUI:ShowCardDetail(card, battleTouchPos, extraParams)
  self:ShowOrRefreshCardDetail(card, battleTouchPos, extraParams)
end

function BattlePanelCardUI:ShowOrRefreshCardDetail(card, battleTouchPos, extraParams)
  if not card then
    return
  end
  EventMgr.Instance.ShowBattleCardDisplay:Dispatch(card, battleTouchPos, extraParams)
end

function BattlePanelCardUI:GetInitCardDetailInfo()
  return {
    cardUid = Vue.ref(0),
    cardTid = Vue.ref(0),
    cardDesc = Vue.ref(""),
    cost = Vue.ref(0)
  }
end

function BattlePanelCardUI:HideCardDetail()
  EventMgr.Instance.HideBattleCardDisplay:Dispatch()
end

function BattlePanelCardUI:UpdateCardDetailPanelPos(cardItem, touchPos)
  if not (cardItem and cardItem.card) or not cardItem.card.value then
    return
  end
  self:ShowOrRefreshCardDetail(cardItem.card.value, touchPos)
end

function BattlePanelCardUI:DealPreCheckCard(preCheckCard, checkCard)
  if nil == preCheckCard or preCheckCard == checkCard then
    return
  end
  if self:IsUsingCardItem(preCheckCard) then
    return
  end
  self:SetCardAnimState(preCheckCard, CommonDefine.CardAnim.CardDisplayBack)
end

function BattlePanelCardUI:ResetCheckCard(isPutBack)
  if self.checkCard and isPutBack then
    self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardPutBack)
  end
  self:SetCheckCard(nil)
  self.checkCardState = nil
  self:HideCardDetail()
end

function BattlePanelCardUI:CheckCardInit(cardItem)
  self:SetCheckCard(cardItem)
  self.checkCardState = CommonDefine.CardCheck.None
  if not cardItem then
    self:HideCardDetail()
  end
end

function BattlePanelCardUI:CheckCardDisplay(cardItem)
  if not cardItem then
    return
  end
  local cardSectorPos = self:GetCardPosAndAngle(cardItem.card.value.uid)
  local cardWorldPos = self.deckRectTransform:TransformPoint(Vector3(cardSectorPos.x, cardSectorPos.y, 0))
  if self.checkCard == cardItem and self.checkCardState == CommonDefine.CardCheck.Display then
    self:UpdateCardDetailPanelPos(cardItem, cardWorldPos)
    return
  end
  self:DealPreCheckCard(self.checkCard, cardItem)
  self:SetCheckCard(cardItem)
  self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardDisplay)
  self.checkCardState = CommonDefine.CardCheck.Display
  self:ShowCardItemDetail(cardItem)
  self:UpdateCardDetailPanelPos(cardItem, cardWorldPos)
  BattleCardShotcutDragDropMgr.Instance:ReplaceDragCard(cardItem)
end

function BattlePanelCardUI:CheckCardReady(cardItem, touchPos)
  if self._previewCard and self._previewCard ~= cardItem then
    self:PutBackPreviewCard()
  end
  if not self:CanUseCard(cardItem.card.value) then
    self:SetCardAnimState(cardItem, CommonDefine.CardAnim.CardDisplayBack)
    self:ResetCheckCard()
    return
  end
  if self.checkCard == cardItem and self.checkCardState == CommonDefine.CardCheck.Ready then
    self:UpdateCardDragState(cardItem, touchPos, true)
    return
  end
  self:DealPreCheckCard(self.checkCard, cardItem)
  self:UpdateCardDragState(cardItem, touchPos, true)
  self:SetCheckCard(cardItem)
  self.checkCardState = CommonDefine.CardCheck.Ready
  self:HideCardDetail()
end

function BattlePanelCardUI:OnPointerDown(cardItem, pointerData)
  if bg.battleDataCenter:IsOpModeInspect() then
    return
  end
  if UIManager.Instance:GetWindow(Urls.DeckCardSelectPanel) then
    return
  end
  if bg.battleRender.battlePhase ~= bc.BattlePhase.Battle then
    return
  end
  if not self:IsInHandMap(cardItem) then
    return
  end
  if self._previewCard then
    if self._previewCard == cardItem then
      UIManager.Instance:CloseByUrl(Urls.BattleCardPreviewPanel)
      self._previewCard = nil
      self._previewCardState = CommonDefine.CardCheck.None
    else
      self:PutBackPreviewCard()
    end
  end
  self.touchDownX = pointerData.position.x
  self.touchDownY = pointerData.position.y
  AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Show_Card")
  self:CheckCardInit(cardItem)
end

function BattlePanelCardUI:OnPointerLong(cardItem)
  self:CheckCardDisplay(cardItem)
end

function BattlePanelCardUI:OnDrag(_, pointerData)
  if bg.battleRender.battlePhase ~= bc.BattlePhase.Battle then
    return
  end
  if not self.touchDownY then
    return
  end
  if bg.isReplay then
    return
  end
  if not self:IsInHandMap(self.checkCard) then
    self.touchDownX = nil
    self.touchDownY = nil
    self:CheckCardInit(nil)
    return
  end
  local pointerPos = pointerData.position
  local isDragUp = pointerPos.y - self.touchDownY >= 10
  local touchPos = ScreenToLocalPos(pointerPos, self.deckRectTransform, self.deckRectTransform)
  if isDragUp and self.checkCard then
    local destPos = self:GetCardDragPos(self.checkCard, pointerPos)
    self:CheckCardReady(self.checkCard, destPos)
    if touchPos.y <= CommonDefine.DeckDisplayY then
      self:UpdateCardDragState(self.checkCard, destPos)
    end
  elseif touchPos.y <= CommonDefine.DeckDisplayY then
    local touchedCardItem = self:GetPointerCardItem(pointerData, touchPos)
    if touchedCardItem then
      self:CheckCardDisplay(touchedCardItem)
    elseif self.checkCard and self.checkCardState == CommonDefine.CardCheck.Ready then
      local destPos = self:GetCardDragPos(self.checkCard, pointerPos)
      self:UpdateCardDragState(self.checkCard, destPos)
    end
  end
  if self.checkCard then
    self.binder:SetActive(self.checkCard.ui.UI_Vx_Card_Choose, self:IsDragCanUse(pointerPos, touchPos))
  end
end

function BattlePanelCardUI:IsDragCanUse(pointerDataPos, touchPos)
  if not self.touchDownX or not self.touchDownY then
    return
  end
  if bg.isReplay then
    return
  end
  local isDragEnough = pointerDataPos.y - self.touchDownY > CommonDefine.DragEnoughToUse or math.abs(pointerDataPos.x - self.touchDownX) > CommonDefine.DragEnoughToUse
  touchPos = touchPos or ScreenToLocalPos(pointerDataPos, self.deckRectTransform, self.deckRectTransform)
  return touchPos.y > CommonDefine.DeckUseY and isDragEnough
end

function BattlePanelCardUI:GetCardDragPos(cardItem, position)
  if cardItem then
    local cardTransform = cardItem.rootRectTransform
    local destPos = ScreenToLocalPos(position, self.uiDelegate:GetTransform(), cardTransform)
    return destPos
  end
end

function BattlePanelCardUI:OnPointerUp(_, pointerData, forceCancel)
  if not self.checkCard then
    return
  end
  if not Application.isFocused then
    forceCancel = true
  end
  if not self:IsInHandMap(self.checkCard) then
    self.touchDownX = nil
    self.touchDownY = nil
    self:CheckCardInit(nil)
    self:ResetSiblingIndex()
    return
  end
  if self:IsUsingCardItem(self.checkCard) then
    self.touchDownX = nil
    self.touchDownY = nil
    self:CheckCardInit(nil)
    self:ResetSiblingIndex()
    return
  end
  if self.checkCardState == CommonDefine.CardCheck.Ready or ApplicationUtils.IsWindowsOrEditor() then
    if self:IsDragCanUse(pointerData.position) then
      local cardData = self.checkCard.card.value
      if not forceCancel and self:CanUseCard(cardData) then
        local destPos = self:GetCardDragPos(self.checkCard, pointerData.position)
        self:UpdateCardDragState(self.checkCard, destPos, false)
        self:UseCard(self.checkCard)
      else
        AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Withdraw")
        self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardPutBack)
      end
    else
      self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardPutBack)
    end
  else
    AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Show_Card_Withdraw")
    self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardDisplayBack)
  end
  self.touchDownX = nil
  self.touchDownY = nil
  self:CheckCardInit(nil)
  self:ResetSiblingIndex()
end

function BattlePanelCardUI:OnPointerExit(_, pointerData)
  if not self.checkCard then
    return
  end
  if self:IsDragCanUse(pointerData.position) then
    self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardPutBack)
  else
    self:SetCardAnimState(self.checkCard, CommonDefine.CardAnim.CardDisplayBack)
  end
  self.touchDownX = nil
  self.touchDownY = nil
  self:CheckCardInit(nil)
  self:ResetSiblingIndex()
end

function BattlePanelCardUI:OnPointerClick()
end

function BattlePanelCardUI:OnTouchCanceled(cardItem)
  self:PutbackCard(cardItem, true, true)
end

function BattlePanelCardUI:GetLocalTouchPoint(position)
  local localPos = ScreenToLocalPos(position, self.deckRectTransform, self.deckRectTransform)
  return localPos
end

function BattlePanelCardUI:GetPointerCardItem(pointerData, localPos)
  localPos = localPos or self:GetLocalTouchPoint(pointerData.position)
  local sectionIndex = self.sector:GetSectionIndexByPoint(localPos)
  local cardItem = self.handIndexCardItemMap[sectionIndex]
  if cardItem and cardItem:GetHandIndex() == sectionIndex and self:IsInHandMap(cardItem) then
    return cardItem
  end
  self:RebuildCardItemCache()
  return self.handIndexCardItemMap[sectionIndex]
end

function BattlePanelCardUI:GetCardIndex(uid)
  local cardList = self.cardMgr:GetHandCardList()
  for index, cardData in ipairs(cardList) do
    if cardData.uid == uid then
      return index
    end
  end
end

function BattlePanelCardUI:GetHandCardCount()
  return #(self.cardMgr:GetHandCardList() or {})
end

function BattlePanelCardUI:GetCardPosAndAngle(uid)
  local index = self:GetCardIndex(uid)
  local card = bg.battleRender.cardMgr:GetCardByUid(uid)
  if not index then
    Logger.Warn("GetCardPosAndAngle wrong : no Index, uid = " .. uid, self.camp, card.camp)
    return
  end
  local pos = self.sector:GetSectionPoint(index)
  local angle = self.sector:GetSectionAngle(index)
  return pos, angle
end

function BattlePanelCardUI:GetCardPosByAngle(angle)
  do return self.sector.GetPointByAngle, self.sector end
  return self.sector.GetPointByAngle, self.sector, angle
end

function BattlePanelCardUI:GetCardItemByUid(cardUid, createIfNone)
  for card, item in pairs(self.cardItemMap) do
    if card.uid == cardUid then
      return item
    end
  end
  if createIfNone then
    local cardItem = self:CreateCardItem(cardUid, self.uiDelegate:GetCardContent().transform, false)
    if cardItem then
      return cardItem
    end
  end
end

function BattlePanelCardUI:CreateCardItem(cardDataOrUid, parentTf, isInitTouchFunc)
  local cardClient
  if type(cardDataOrUid) == "number" then
    cardClient = self.cardMgr:GetCardByUid(cardDataOrUid)
  else
    cardClient = cardDataOrUid
  end
  if not cardClient then
    return
  end
  local cardItem = self:GetNewCardItem()
  cardItem:SetIsNeedHighDescMode(false)
  cardItem:SetCardUI(self, self.uiDelegate:GetCardContent())
  parentTf = parentTf or self.uiDelegate:GetCardContent().transform
  cardItem:Init(cardClient, parentTf, isInitTouchFunc and self:GetCardTouchFuncs() or {})
  self.cardItemMap[cardClient] = cardItem
  return cardItem
end

function BattlePanelCardUI:GetCardTouchFuncs()
  if self.camp ~= bg.battleDataCenter:GetMyCamp() then
    return {}
  end
  return {
    OnPointerDown = System.fn(self, self.OnPointerDown),
    OnPointerLong = System.fn(self, self.OnPointerLong),
    OnDrag = System.fn(self, self.OnDrag),
    OnPointerUp = System.fn(self, self.OnPointerUp),
    OnPointerClick = System.fn(self, self.OnPointerClick),
    OnPointerExit = System.fn(self, self.OnPointerExit)
  }
end

function BattlePanelCardUI:GetCardMaxHandIdx()
  local rst = 0
  for _, cardItem in pairs(self.cardItemMap) do
    rst = math.max(rst, cardItem:GetHandIndex() or 0)
  end
  return rst
end

function BattlePanelCardUI:GetSelectingCardItem()
  local draggingCardItem = BattleCardShotcutDragDropMgr.Instance:GetDraggingCardItem()
  local selectingCardItem = draggingCardItem or self._previewCard
  if not selectingCardItem then
    return nil
  end
  for _, cardItem in pairs(self.cardItemMap) do
    if selectingCardItem == cardItem then
      return cardItem
    end
  end
end

function BattlePanelCardUI:GetCardByHandIdx(handIdx)
  if not handIdx then
    return nil
  end
  for _, cardItem in pairs(self.cardItemMap) do
    if cardItem:GetHandIndex() == handIdx then
      return cardItem
    end
  end
end

function BattlePanelCardUI:OnUnbind()
  if bg.battleRender then
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
  if self.embryoBornEffects then
    for i = 1, #self.embryoBornEffects do
      self.embryoBornEffects[i]:Clear()
    end
  end
  if self.swallowEmbryoEffects then
    for i = 1, #self.swallowEmbryoEffects do
      self.swallowEmbryoEffects[i]:Clear()
    end
  end
  if self.followTween then
    self.followTween:Kill(true)
    self.followTween = nil
  end
  for _, tween in pairs(self.cardTweeners) do
    if nil ~= tween then
      tween:Kill(false)
    end
  end
  self._cachedCardFlyUidMap = nil
  self.battleCardPool:Clear()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattlePanelCardUI:HideCardContent()
end

function BattlePanelCardUI:BindReplayHandCardsToMap()
  if not bg.isReplay then
    return
  end
  local handCardDataList = self.cardMgr:GetHandCardList()
  for index, cardData in ipairs(handCardDataList) do
    if not self.cardItemMap[cardData] then
      local cardItem = self:FindCardItemByUid(cardData.uid)
      if cardItem and not IsNil(cardItem.rootRectTransform) then
        self.cardItemMap[cardData] = cardItem
        cardItem:SetHandIndex(index)
        self:UpdateCardItemCache(cardItem)
      end
    end
  end
end

function BattlePanelCardUI:ShowCardContent()
  self.isPVPSelecting.value = false
  BattleHandCardLogUtils.LogInfo("ShowCardContent", self, "selectEnd relayout")
  self:BindReplayHandCardsToMap()
  self:RelayoutHandCard()
end

return BattlePanelCardUI
