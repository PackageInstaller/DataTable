local AutoChessShopRefreshNode = class("AutoChessShopRefreshNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessShopRefreshNode:OnEnter()
	AutoChessData:UpdateShopItemData(self.blackboard:GetGameType(), self.actionData.shopItems_)

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessShopRefreshNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessShopRefreshNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessShopRefreshNode
