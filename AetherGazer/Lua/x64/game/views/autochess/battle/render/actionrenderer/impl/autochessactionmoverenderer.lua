local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")
local var_0_1 = class("AutoChessActionMoveRenderer", var_0_0)

function var_0_1.OnPlay(arg_1_0)
	arg_1_0.tweenDataList = {}

	local var_1_0 = AutoChessBattleRenderer.GetInstance():GetBattleView()
	local var_1_1 = var_1_0:GetChessFormationCount()
	local var_1_2 = var_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.moveDataList) do
		local var_1_3 = iter_1_1.chessUniquiId
		local var_1_4 = iter_1_1.newPos

		var_1_2 = math.max(var_1_2, var_1_4)

		local var_1_5 = AutoChessData:GetPlayerTypeByChessUid(var_1_3)
		local var_1_6 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_1_3)

		if var_1_6 then
			local var_1_7 = var_1_6:GetLocalPos()
			local var_1_8 = var_1_0:GetChessPosByPlayerType(var_1_5, var_1_4)
			local var_1_9 = {
				chessItemView = var_1_6,
				originalPos = var_1_7,
				targetPos = var_1_8
			}

			table.insert(arg_1_0.tweenDataList, var_1_9)
		else
			Debug.Log("AutoChessActionMoveRenderer:OnPlay() chessItemView is nil, id = " .. var_1_3)
			arg_1_0:OnControllerFinish()
		end
	end

	local var_1_10 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.LEAN_TWEEN)

	var_1_10:RegistFinishCallback(handler(arg_1_0, arg_1_0.OnControllerFinish))
	var_1_10:Value(0, 1, 0.5, LeanTweenType.easeOutCubic)
	var_1_10:RegistTweenUpdateCallback(handler(arg_1_0, arg_1_0.OnTweenUpdate))
	var_1_10:Play()

	if var_1_1 < var_1_2 then
		var_1_0:PlayChangeBgAnim(var_1_2)
	end
end

function var_0_1.OnTweenUpdate(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.tweenDataList) do
		local var_2_0 = Vector3.Lerp(iter_2_1.originalPos, iter_2_1.targetPos, arg_2_1)

		iter_2_1.chessItemView:SetLocalPos(var_2_0)
	end
end

function var_0_1.OnControllerFinish(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.tweenDataList or {}) do
		iter_3_1.chessItemView:SetLocalPos(iter_3_1.targetPos)
	end

	arg_3_0:Finish()
end

return var_0_1
