local var_0_0 = import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")
local var_0_1 = class("AutoChessMoveNode", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.moveDataList) do
		local var_1_0 = iter_1_1.chessUniquiId
		local var_1_1 = iter_1_1.newPos

		AutoChessData:GetChessData(var_1_0).index = var_1_1
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
