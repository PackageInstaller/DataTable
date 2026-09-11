local AutoChessAddBuffNode = class("AutoChessAddBuffNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessAddBuffNode:OnEnter()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.addBuffDataList) do
		AutoChessData:AddBuff(iter_1_1.targetBuffData, iter_1_1.targetType, iter_1_1.targetUid)
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessAddBuffNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessAddBuffNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessAddBuffNode
