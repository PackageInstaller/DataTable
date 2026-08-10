local var_0_0 = import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")
local var_0_1 = class("AutoChessEffectSummonNode", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	local var_1_0 = arg_1_0.blackboard:GetGameType()
	local var_1_1 = AutoChessData:GetGameStatus(var_1_0)
	local var_1_2 = AutoChessTools.IsPrepareStatus(var_1_1)
	local var_1_3 = var_1_2 and AutoChessData:GetPrepareData(var_1_0).playerData or AutoChessData:GetSimulatePlayerData(arg_1_0.actionData.playerType)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.chessDataList) do
		AutoChessData:AddChess(var_1_3, clone(iter_1_1))

		if not var_1_2 then
			AutoChessBattleRenderer.GetInstance():GetBattleView():AddChess(arg_1_0.actionData.playerType, iter_1_1)
		end
	end

	if var_1_2 then
		manager.notify:Invoke("AUTO_CHESS_FORMATION_UPDATE")
	end

	arg_1_0.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(arg_1_0.actionData)
end

function var_0_1.OnExecute(arg_2_0)
	if arg_2_0:IsRenderEnd() then
		arg_2_0.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function var_0_1.IsRenderEnd(arg_3_0)
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(arg_3_0.rendererId)
end

return var_0_1
