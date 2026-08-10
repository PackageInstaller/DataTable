local var_0_0 = class("AtuoChessActionDeadRenderer", AutoChessActionBaseRenderer)

function var_0_0.OnPlay(arg_1_0)
	arg_1_0.finishCount = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.deadChessList) do
		local var_1_0 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_1_1)

		if var_1_0 then
			local var_1_1 = var_1_0:GetAnimator()
			local var_1_2 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

			var_1_2:RegistFinishCallback(handler(arg_1_0, arg_1_0.OnControllerFinish))
			var_1_2:PlayAnim(var_1_1, "ChessItemDeadAnim")
		else
			Debug.Log("AutoChessActionDeadRenderer:OnPlay chessItemView is nil, chessUniqueId: " .. iter_1_1)
			arg_1_0:OnControllerFinish()
		end
	end
end

function var_0_0.OnControllerFinish(arg_2_0)
	arg_2_0.finishCount = arg_2_0.finishCount + 1

	local var_2_0 = arg_2_0.actionData.deadChessList[arg_2_0.finishCount]

	if not AutoChessBattleRenderer.GetInstance():CheckDeathWhisper(var_2_0) then
		AutoChessBattleRenderer.GetInstance():RemoveChessItemByUniqueId(var_2_0)
	end

	if arg_2_0.finishCount == #arg_2_0.actionData.deadChessList then
		arg_2_0:Finish()
	end
end

return var_0_0
