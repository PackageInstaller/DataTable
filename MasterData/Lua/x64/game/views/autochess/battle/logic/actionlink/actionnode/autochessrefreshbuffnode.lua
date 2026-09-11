local AutoChessRefreshBuffNode = class("AutoChessRefreshBuffNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessRefreshBuffNode:OnEnter()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.refreshBuffDataList) do
		AutoChessData:RefreshBuff(iter_1_1)
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessRefreshBuffNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessRefreshBuffNode:IsRenderEnd()
	return true
end

return AutoChessRefreshBuffNode
