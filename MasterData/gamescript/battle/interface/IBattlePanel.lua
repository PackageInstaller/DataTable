local IBattlePanel = System.NewInterface("IBattlePanel")

function IBattlePanel:IsReady()
end

function IBattlePanel:Tick(deltaTime)
end

function IBattlePanel:ShowRespawn(isRespawning, callback)
end

function IBattlePanel:HideRespawn()
end

function IBattlePanel:OnBattleFinish(winCamp)
end

function IBattlePanel:HideUI(isHide)
end

function IBattlePanel:GetCardUI(camp)
end

function IBattlePanel:GetUIVisible()
end

function IBattlePanel:AddNewCard(newCards, camp)
end

function IBattlePanel:OnUseCard(cardUid, deck)
end

function IBattlePanel:GetCardItemByUid(cardUid, createIfNone)
end

function IBattlePanel:ShowCardDetail(card)
end

function IBattlePanel:OnRelicEffect(relicUid)
end

return IBattlePanel
