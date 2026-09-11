local AutoChessDamageNode = class("AutoChessDamageNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessDamageNode:OnEnter()
	for iter_1_0, iter_1_1 in ipairs(self.actionData.targetHpChangeData) do
		local var_1_0 = AutoChessData:GetChessData(iter_1_1.chessUid)

		if var_1_0 then
			var_1_0.attributeData:AddHp(iter_1_1.hpChange)
		else
			Debug.Log("AutoChessDamageNode: 目标不存在, chessUid = " .. iter_1_1.chessUid)
		end
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessDamageNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessDamageNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessDamageNode
