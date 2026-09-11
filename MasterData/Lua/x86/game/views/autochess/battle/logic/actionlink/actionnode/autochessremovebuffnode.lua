local AutoChessRemoveBuffNode = class("AutoChessRemoveBuffNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessRemoveBuffNode:OnEnter()
	AutoChessData:RemoveBuff(self.actionData.buffUid)

	for iter_1_0, iter_1_1 in ipairs(self.actionData.chessAttrChangeDataList) do
		AutoChessData:GetChessData(iter_1_1.chessUid).attributeData:Add(iter_1_1.attrData)
	end

	AutoChessData:UpdateAttrData(self.blackboard:GetGameType(), self.actionData.globalAttrChangeDataList)

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessRemoveBuffNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessRemoveBuffNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessRemoveBuffNode
