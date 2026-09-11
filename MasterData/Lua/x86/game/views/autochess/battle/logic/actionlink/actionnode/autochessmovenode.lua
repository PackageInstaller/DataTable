local AutoChessMoveNode = class("AutoChessMoveNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessMoveNode:OnEnter()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.moveDataList) do
		AutoChessData:GetChessData(iter_1_1.chessUniquiId).index = iter_1_1.newPos
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessMoveNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessMoveNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessMoveNode
