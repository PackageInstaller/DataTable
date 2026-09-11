local AutoChessRefreshNode = class("AutoChessRefreshNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessRefreshNode:OnEnter()
	AutoChessData:UpdateChessTeamDataList(self.blackboard:GetGameType(), self.actionData.refreshChessList)

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessRefreshNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessRefreshNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessRefreshNode
