local AutoChessEffectSummonNode = class("AutoChessEffectSummonNode", (import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")))

function AutoChessEffectSummonNode:OnEnter()
	local var_1_0 = self.blackboard:GetGameType()
	local var_1_1 = AutoChessTools.IsPrepareStatus((AutoChessData:GetGameStatus(var_1_0)))

	for iter_1_0, iter_1_1 in ipairs(self.actionData.chessDataList) do
		AutoChessData:AddChess((var_1_1 or nil) and (AutoChessData:GetPrepareData(var_1_0).playerData or AutoChessData:GetSimulatePlayerData(self.actionData.playerType)), clone(iter_1_1))

		if not var_1_1 then
			AutoChessBattleRenderer.GetInstance():GetBattleView():AddChess(self.actionData.playerType, iter_1_1)
		end
	end

	if var_1_1 then
		manager.notify:Invoke("AUTO_CHESS_FORMATION_UPDATE")
	end

	self.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(self.actionData)
end

function AutoChessEffectSummonNode:OnExecute()
	if self:IsRenderEnd() then
		self.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function AutoChessEffectSummonNode:IsRenderEnd()
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(self.rendererId)
end

return AutoChessEffectSummonNode
