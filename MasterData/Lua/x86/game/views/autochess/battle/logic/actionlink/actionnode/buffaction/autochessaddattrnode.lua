local AutoChessAddAttrNode = class("AutoChessAddAttrNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessAddAttrNode:OnEnter()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.targetAttributeDataList) do
		AutoChessData:GetChessData(iter_1_1.chessUid).attributeData:Add(iter_1_1.attrData)
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessAddAttrNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessAddAttrNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessAddAttrNode
