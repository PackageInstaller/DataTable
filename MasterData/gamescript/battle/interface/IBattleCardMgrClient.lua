local IBattleCardMgrClient = System.NewInterface("IBattleCardMgrClient")

function IBattleCardMgrClient:GetCardByUid(uid)
end

function IBattleCardMgrClient:ChangeRealCardDeck(frameData)
end

function IBattleCardMgrClient:IsHaveAvailCard()
end

function IBattleCardMgrClient:GetCardListByDeck(cardDeck)
end

return IBattleCardMgrClient
