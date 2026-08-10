local var_0_0 = import("game.views.autoChess.battle.logic.actionLink.actionNode.AutoChessActionBaseNode")
local var_0_1 = class("AutoChessFightNode", var_0_0)

function var_0_1.OnCtor(arg_1_0)
	arg_1_0.fightAnimEndHandler = handler(arg_1_0, arg_1_0.OnFightAnimEnd)
end

function var_0_1.OnEnter(arg_2_0)
	arg_2_0:UpdateLogicData()

	arg_2_0.rendererId = AutoChessBattleRenderer.GetInstance():RenderAction(arg_2_0.actionData)
end

function var_0_1.UpdateLogicData(arg_3_0)
	local var_3_0
	local var_3_1
	local var_3_2
	local var_3_3

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.actionData.fightDataList) do
		local var_3_4 = iter_3_1.chessUniquiId
		local var_3_5 = AutoChessData:GetPlayerTypeByChessUid(var_3_4)

		if var_3_5 == AutoChessConst.PLAYER_TYPE.SELF then
			var_3_0 = iter_3_1
			var_3_1 = AutoChessData:GetChessData(var_3_4)
		elseif var_3_5 == AutoChessConst.PLAYER_TYPE.OPPONENT then
			var_3_2 = iter_3_1
			var_3_3 = AutoChessData:GetChessData(var_3_4)
		end
	end

	if var_3_0 == nil or var_3_2 == nil then
		Debug.LogError("AutoChessBattleView:OnRenderChessFightAction fight data error")

		return
	end

	var_3_1.attributeData.hp = var_3_1.attributeData.hp + var_3_0.hpChange
	var_3_3.attributeData.hp = var_3_3.attributeData.hp + var_3_2.hpChange
	arg_3_0.actionData.selfChessDataHp = var_3_1.attributeData.hp
	arg_3_0.actionData.opponentChessDataHp = var_3_3.attributeData.hp
end

function var_0_1.OnExecute(arg_4_0)
	if arg_4_0:IsRenderEnd() then
		arg_4_0.status = AutoChessConst.ACTION_NODE_STATUS.FINISH
	end
end

function var_0_1.IsRenderEnd(arg_5_0)
	return AutoChessBattleRenderer.GetInstance():IsRendererFinish(arg_5_0.rendererId)
end

return var_0_1
