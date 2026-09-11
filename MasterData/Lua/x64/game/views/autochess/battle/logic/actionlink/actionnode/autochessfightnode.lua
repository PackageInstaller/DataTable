local AutoChessFightNode = class("AutoChessFightNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessFightNode:OnCtor()
	self.fightAnimEndHandler = handler(self, self.OnFightAnimEnd)
end

function AutoChessFightNode:OnEnter()
	self:UpdateLogicData()

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessFightNode:UpdateLogicData()
	local var_3_0
	local var_3_1
	local var_3_2
	local var_3_3

	for iter_3_0, iter_3_1 in ipairs(self.actionData.fightDataList) do
		local var_3_4 = AutoChessData:GetPlayerTypeByChessUid(iter_3_1.chessUniquiId)

		if var_3_4 == AutoChessConst.PLAYER_TYPE.SELF then
			var_3_0 = iter_3_1
			var_3_1 = AutoChessData:GetChessData(iter_3_1.chessUniquiId)
		elseif var_3_4 == AutoChessConst.PLAYER_TYPE.OPPONENT then
			var_3_2 = iter_3_1
			var_3_3 = AutoChessData:GetChessData(iter_3_1.chessUniquiId)
		end
	end

	if var_3_0 == nil or var_3_2 == nil then
		Debug.LogError("AutoChessBattleView:OnRenderChessFightAction fight data error")

		return
	end

	var_3_1.attributeData.hp = var_3_1.attributeData.hp + var_3_0.hpChange
	var_3_3.attributeData.hp = var_3_3.attributeData.hp + var_3_2.hpChange
	self.actionData.selfChessDataHp = var_3_1.attributeData.hp
	self.actionData.opponentChessDataHp = var_3_3.attributeData.hp
end

function AutoChessFightNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessFightNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessFightNode
