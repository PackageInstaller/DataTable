local PvPBattleCardMgrClient, Super = System.NewClass("PvPBattleCardMgrClient", IBattleCardMgrClient)

function PvPBattleCardMgrClient:ctor()
  Super.ctor(self)
  self.cardMgrList = {}
end

function PvPBattleCardMgrClient:Dispose()
  self.isDisposed = true
  for _, cardMgr in pairs(self.cardMgrList) do
    cardMgr:Dispose()
  end
  self.cardMgrList = nil
end

function PvPBattleCardMgrClient:Tick(deltaTime)
  for _, cardMgr in pairs(self.cardMgrList) do
    cardMgr:Tick()
  end
end

function PvPBattleCardMgrClient:InitAllCards(cards)
  for camp, cardList in pairs(cards) do
    local cardMgr = self.cardMgrList[camp] or BattleCardMgrClient(camp)
    self.cardMgrList[camp] = cardMgr
    cardMgr:InitAllCards(cardList)
  end
end

function PvPBattleCardMgrClient:GetCardMgrByCamp(camp)
  return self.cardMgrList[camp]
end

function PvPBattleCardMgrClient:GetCardByUid(uid)
  for _, cardMgr in pairs(self.cardMgrList) do
    local card = cardMgr:GetCardByUid(uid)
    if card then
      return card
    end
  end
end

function PvPBattleCardMgrClient:GetCardByConfigId(tid)
  for _, cardMgr in pairs(self.cardMgrList) do
    local card = cardMgr:GetCardByConfigId(tid)
    if card then
      return card
    end
  end
end

function PvPBattleCardMgrClient:ChangeRealCardDeck(frameData)
  for _, cardMgr in pairs(self.cardMgrList) do
    cardMgr:ChangeRealCardDeck(frameData)
  end
end

function PvPBattleCardMgrClient:IsHaveAvailCard(camp)
  local cardMgr = self.cardMgrList[camp]
  do return cardMgr.IsHaveAvailCard end
  return cardMgr.IsHaveAvailCard, cardMgr
end

function PvPBattleCardMgrClient:GetCardListByDeck(cardDeck, camp)
  local cardMgr = self.cardMgrList[camp]
  do return cardMgr.GetCardListByDeck, cardMgr end
  return cardMgr.GetCardListByDeck, cardMgr, cardDeck
end

return PvPBattleCardMgrClient
