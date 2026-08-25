local BattleCardItemLifecycle = NewClass("BattleCardItemLifecycle")

function BattleCardItemLifecycle:ctor(cardUI)
  self.cardUI = cardUI
  self._detachAnimCardSet = {}
end

function BattleCardItemLifecycle:MarkDetachAnim(cardItem)
  if not cardItem then
    return
  end
  self._detachAnimCardSet[cardItem] = true
end

function BattleCardItemLifecycle:ClearDetachAnim(cardItem)
  if self._detachAnimCardSet and cardItem then
    self._detachAnimCardSet[cardItem] = nil
  end
end

function BattleCardItemLifecycle:IsInMap(cardItem)
  do return self.cardUI.IsInHandMap, self.cardUI end
  return self.cardUI.IsInHandMap, self.cardUI, cardItem
end

function BattleCardItemLifecycle:GetInPoolByUid(cardUid)
  if not cardUid then
    return
  end
  local pool = self.cardUI.battleCardPool
  if not pool or not pool.usingObjects then
    return
  end
  for _, cardItem in pairs(pool.usingObjects) do
    if cardItem:GetUid() == cardUid and not cardItem.isBlessingDisplay and cardItem.binder and not cardItem.binder:isDestroyed() then
      return cardItem
    end
  end
end

function BattleCardItemLifecycle:IsPostPlayRecycleCardItem(cardItem)
  if not cardItem or cardItem.isBlessingDisplay then
    return false
  end
  local cardUI = self.cardUI
  local CardAnim = CommonDefine.CardAnim
  if cardItem:IsInState(CardAnim.CardUseBack) or cardItem:IsInState(CardAnim.CardPutBack) or cardItem:IsInState(CardAnim.CardDisplayBack) or cardItem:IsInState(CardAnim.CardRelayout) then
    return false
  end
  local cardData = cardItem.card and cardItem.card.value
  if cardData and cardData.deck == bc.CardDeck.HandDeck and cardUI:IsInCardItemMap(cardItem) and not cardUI:IsUsingCardItem(cardItem) then
    return false
  end
  if cardUI:IsUsingCardItem(cardItem) then
    return true
  end
  if cardItem:IsInState(CardAnim.CardUse) or cardItem:IsInState(CardAnim.CardDisappear) or cardItem:IsInState(CardAnim.CardConsume) or cardItem:IsInState(CardAnim.CardRecordUse) or cardItem:IsInState(CardAnim.CardForceUse) then
    return true
  end
  if not cardUI:IsInCardItemMap(cardItem) then
    return true
  end
  return false
end

function BattleCardItemLifecycle:DestroyExistingByUid(cardUid)
  if not cardUid then
    return
  end
  local cardUI = self.cardUI
  local destroySet = {}
  for _, cardItem in pairs(cardUI.cardItemMap) do
    if cardItem and cardItem:GetUid() == cardUid and self:IsPostPlayRecycleCardItem(cardItem) then
      destroySet[cardItem] = true
    end
  end
  local pool = cardUI.battleCardPool
  if pool and pool.usingObjects then
    for _, cardItem in pairs(pool.usingObjects) do
      if cardItem and cardItem:GetUid() == cardUid and self:IsPostPlayRecycleCardItem(cardItem) then
        destroySet[cardItem] = true
      end
    end
  end
  for cardItem, _ in pairs(destroySet) do
    self:DestroyCardItemNoPool(cardItem)
  end
end

function BattleCardItemLifecycle:DestroyCardItemNoPool(cardItem)
  if not cardItem then
    return
  end
  local cardUI = self.cardUI
  local cardData = cardItem.card and cardItem.card.value
  if cardData and cardUI.cardItemMap[cardData] == cardItem then
    cardUI.cardItemMap[cardData] = nil
  end
  cardUI:RemoveCardItemCache(cardItem)
  cardUI:ClearPutbackCardItem(cardItem)
  self:ClearDetachAnim(cardItem)
  self:KillCardTweener(cardItem)
  if cardItem.binder and not cardItem.binder:isDestroyed() then
    cardItem.binder:teardown()
  end
  local pool = cardItem.pool
  if pool and pool.usingObjects then
    pool.usingObjects[cardItem] = nil
    cardItem.pool = nil
  end
end

function BattleCardItemLifecycle:FindByUid(cardUid)
  return self.cardUI:GetCardItemByUid(cardUid) or self:GetInPoolByUid(cardUid)
end

function BattleCardItemLifecycle:IsHandReturnAnim(animState)
  return animState == CommonDefine.CardAnim.CardPutBack or animState == CommonDefine.CardAnim.CardDisplayBack or animState == CommonDefine.CardAnim.CardUseBack or animState == CommonDefine.CardAnim.CardRelayout
end

function BattleCardItemLifecycle:CanPlayAnim(cardItem, animState)
  if not cardItem then
    return false
  end
  if self:IsInMap(cardItem) then
    return true
  end
  return not self:IsHandReturnAnim(animState)
end

function BattleCardItemLifecycle:ClearPutbackByUid(cardUid)
  if not cardUid then
    return
  end
  local cardUI = self.cardUI
  if not cardUI.putbackTicks then
    return
  end
  for cardItem, ticker in pairs(cardUI.putbackTicks) do
    if cardItem and cardItem:GetUid() == cardUid then
      bg.battleRender:UnperformWithDelay(ticker)
      cardUI.putbackTicks[cardItem] = nil
      return
    end
  end
end

function BattleCardItemLifecycle:ClearUseCardStateByUid(cardUid)
  if not cardUid then
    return
  end
  local cardUI = self.cardUI
  local cardItem = self:FindByUid(cardUid)
  if cardItem then
    cardUI:ClearPutbackCardItem(cardItem)
  else
    self:ClearPutbackByUid(cardUid)
  end
  if cardUI.usingCardUidMap then
    cardUI.usingCardUidMap[cardUid] = nil
  end
end

function BattleCardItemLifecycle:ClearCheckCardIfNeeded(cardItem)
  local cardUI = self.cardUI
  if cardUI.checkCard == cardItem then
    cardUI.touchDownX = nil
    cardUI.touchDownY = nil
    cardUI:CheckCardInit(nil)
  end
end

function BattleCardItemLifecycle:UnregisterFromMap(card, cardItem)
  local cardUI = self.cardUI
  cardUI.cardItemMap[card] = nil
  if cardItem.card.value then
    cardUI.cardItemMap[cardItem.card.value] = nil
  end
  cardUI:RemoveCardItemCache(cardItem)
  self:ClearCheckCardIfNeeded(cardItem)
end

function BattleCardItemLifecycle:KillCardTweener(cardItem)
  local cardUI = self.cardUI
  if cardUI.cardTweeners then
    local tweener = cardUI.cardTweeners[cardItem]
    if tweener then
      tweener:Kill()
      cardUI.cardTweeners[cardItem] = nil
    end
  end
end

function BattleCardItemLifecycle:ClearInsertFlyState(cardItem)
  if not cardItem then
    return
  end
  local cardUI = self.cardUI
  if cardUI.insertingCards then
    table.delete(cardUI.insertingCards, cardItem)
  end
  if cardItem.CancelInsertAnim then
    cardItem:CancelInsertAnim()
  end
  if bg.battleRender then
    bg.battleRender:UnperformWithAllDelaysByTarget(cardItem)
  end
end

function BattleCardItemLifecycle:ForceRecycle(cardItem)
  if not cardItem or IsNil(cardItem.rootRectTransform) then
    return
  end
  BattleHandCardLogUtils.LogForceRecycle(self.cardUI, cardItem, "ForceRecycle")
  local cardUI = self.cardUI
  self:ClearInsertFlyState(cardItem)
  self:ClearCheckCardIfNeeded(cardItem)
  local cardData = cardItem.card and cardItem.card.value
  if cardData and cardUI.cardItemMap[cardData] == cardItem then
    cardUI.cardItemMap[cardData] = nil
  end
  cardUI:RemoveCardItemCache(cardItem)
  cardUI:ClearPutbackCardItem(cardItem)
  self:ClearDetachAnim(cardItem)
  self:KillCardTweener(cardItem)
  cardItem:SetClickable(false)
  if cardItem.binder then
    cardItem.binder:teardown()
  end
end

function BattleCardItemLifecycle:IsOrphan(cardItem)
  if not cardItem or IsNil(cardItem.rootRectTransform) then
    return false
  end
  if cardItem.isBlessingDisplay then
    return false
  end
  local cardUI = self.cardUI
  if cardUI:IsInCardItemMap(cardItem) then
    return false
  end
  local uid = cardItem:GetUid()
  if uid then
    local handMap = cardUI.cardMgr:GetCardMapByDeck(bc.CardDeck.HandDeck)
    if handMap[uid] then
      return false
    end
    if bg.isReplay then
      local selectInitMap = cardUI.cardMgr:GetCardMapByDeck(bc.CardDeck.SelectInitDeck)
      if selectInitMap[uid] then
        return false
      end
      if not self._detachAnimCardSet[cardItem] and cardItem.GetHandIndex and cardItem:GetHandIndex() then
        return false
      end
    end
  end
  if cardUI.insertingCards then
    for i = 1, #cardUI.insertingCards do
      if cardUI.insertingCards[i] == cardItem then
        return false
      end
    end
  end
  if cardItem.isInserting and cardItem.isInserting.value then
    return false
  end
  if cardUI.cardTweeners and cardUI.cardTweeners[cardItem] then
    return false
  end
  if self._detachAnimCardSet[cardItem] then
    local cardUid = cardItem:GetUid()
    local handMap = cardUI.cardMgr:GetCardMapByDeck(bc.CardDeck.HandDeck)
    if cardUid and not handMap[cardUid] and not cardUI:IsUsingCardItem(cardItem) then
      if cardItem:IsInAnyAnimState() then
        return false
      end
      return true
    end
    return false
  end
  if cardUI._previewCard == cardItem or cardUI.checkCard == cardItem then
    return false
  end
  local cardData = cardItem.card and cardItem.card.value
  if cardData and cardData.config and cardData.config.isDisplay then
    return false
  end
  if cardData and cardData.deck == bc.CardDeck.HandDeck then
    local handMap = cardUI.cardMgr:GetCardMapByDeck(bc.CardDeck.HandDeck)
    if handMap[cardData.uid] then
      return false
    end
  end
  if cardItem:IsInAnyAnimState() then
    return false
  end
  local pos = cardItem.rootRectTransform.anchoredPosition
  local outPos = BattleCardItem.OutOfScreenPos
  if pos.x == outPos.x and pos.y == outPos.y then
    return false
  end
  return true
end

function BattleCardItemLifecycle:TryRecycleOrphanByUid(cardUid)
  if not cardUid then
    return
  end
  local pool = self.cardUI.battleCardPool
  if not pool or not pool.usingObjects then
    return
  end
  for _, cardItem in pairs(pool.usingObjects) do
    if cardItem:GetUid() == cardUid and self:IsOrphan(cardItem) then
      self:ForceRecycle(cardItem)
      return
    end
  end
end

function BattleCardItemLifecycle:SweepOrphans()
  local pool = self.cardUI.battleCardPool
  if not pool or not pool.usingObjects then
    return
  end
  for _, cardItem in pairs(pool.usingObjects) do
    if self:IsOrphan(cardItem) then
      self:ForceRecycle(cardItem)
    end
  end
  self:SweepOrphanTransforms()
end

function BattleCardItemLifecycle:SweepOrphanTransforms()
  if not bg.isReplay then
    return
  end
  local cardUI = self.cardUI
  local cardContent = cardUI.uiDelegate and cardUI.uiDelegate.GetCardContent and cardUI.uiDelegate:GetCardContent()
  if not cardContent or IsNil(cardContent) then
    return
  end
  local contentTf = cardContent.transform
  if not contentTf or IsNil(contentTf) then
    return
  end
  local mapTransformSet = {}
  local uidMapTransform = {}
  for _, cardItem in pairs(cardUI.cardItemMap) do
    if cardItem and cardItem.rootRectTransform and not IsNil(cardItem.rootRectTransform) then
      mapTransformSet[cardItem.rootRectTransform] = true
      local uid = cardItem.GetUid and cardItem:GetUid()
      if uid then
        uidMapTransform[uid] = cardItem.rootRectTransform
      end
    end
  end
  if cardUI._previewCard and cardUI._previewCard.rootRectTransform and not IsNil(cardUI._previewCard.rootRectTransform) then
    mapTransformSet[cardUI._previewCard.rootRectTransform] = true
  end
  if cardUI.checkCard and cardUI.checkCard.rootRectTransform and not IsNil(cardUI.checkCard.rootRectTransform) then
    mapTransformSet[cardUI.checkCard.rootRectTransform] = true
  end
  local poolTransformItemMap = {}
  local pool = cardUI.battleCardPool
  if pool and pool.usingObjects then
    for _, cardItem in pairs(pool.usingObjects) do
      if cardItem and cardItem.rootRectTransform and not IsNil(cardItem.rootRectTransform) then
        poolTransformItemMap[cardItem.rootRectTransform] = cardItem
      end
    end
  end
  for i = contentTf.childCount - 1, 0, -1 do
    local childTf = contentTf:GetChild(i)
    if childTf and not mapTransformSet[childTf] then
      local orphanItem = poolTransformItemMap[childTf]
      if orphanItem then
        local uid = orphanItem.GetUid and orphanItem:GetUid()
        local isDuplicate = uid and uidMapTransform[uid] and uidMapTransform[uid] ~= childTf
        if isDuplicate or self:IsOrphan(orphanItem) then
          self:ForceRecycle(orphanItem)
        end
      else
        childTf.gameObject:SetActive(false)
      end
    end
  end
end

function BattleCardItemLifecycle:RemoveCards(cards, isDispose)
  BattleHandCardLogUtils.LogRemoveCards(self.cardUI, cards, isDispose, "RemoveCards")
  local cardUI = self.cardUI
  for _, card in ipairs(cards) do
    local cardItem = cardUI.cardItemMap[card] or self:FindByUid(card.uid)
    if cardItem then
      self:UnregisterFromMap(card, cardItem)
      if isDispose then
        self:ClearInsertFlyState(cardItem)
        self:ClearDetachAnim(cardItem)
        cardItem.binder:teardown()
      else
        self:MarkDetachAnim(cardItem)
      end
    elseif bg.isReplay then
      self:TryRecycleOrphanByUid(card.uid)
    end
  end
end

function BattleCardItemLifecycle:FreeCardItem(cardItem, isForce)
  if not cardItem then
    return
  end
  if isForce then
    self:ClearInsertFlyState(cardItem)
    self:RemoveCards({
      cardItem.card.value
    })
    self:ClearDetachAnim(cardItem)
    cardItem.binder:teardown()
  else
    local cardUI = self.cardUI
    local isHold = false
    for _, v in pairs(cardUI.cardItemMap) do
      if v == cardItem then
        isHold = true
        break
      end
    end
    if not isHold then
      cardUI:ClearPutbackCardItem(cardItem)
      self:ClearDetachAnim(cardItem)
      cardItem.binder:teardown()
    end
  end
end

return BattleCardItemLifecycle
