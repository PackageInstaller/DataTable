local AutoChessDeadNode = class("AutoChessDeadNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessDeadNode:OnEnter()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.deadChessList) do
		AutoChessData:RemoveChess(iter_1_1)
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessDeadNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessDeadNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessDeadNode
