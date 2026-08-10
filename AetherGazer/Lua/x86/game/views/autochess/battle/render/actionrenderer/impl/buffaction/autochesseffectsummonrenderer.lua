local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")
local var_0_1 = class("AutoChessEffectSummonRenderer", var_0_0)

function var_0_1.OnBuffInvokeAnimEnd(arg_1_0)
	arg_1_0.finishCount = 0

	local var_1_0 = arg_1_0.actionData.chessDataList and #arg_1_0.actionData.chessDataList or 0

	if var_1_0 == 0 then
		arg_1_0:Finish()

		return
	end

	for iter_1_0 = 1, var_1_0 do
		local var_1_1 = clone(arg_1_0.actionData.chessDataList[iter_1_0])
		local var_1_2 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_1_1.uniqueId)

		if var_1_2 then
			local var_1_3 = var_1_2:GetAnimator()
			local var_1_4 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

			var_1_4:RegistFinishCallback(handler(arg_1_0, arg_1_0.OnSummonAnimEnd))

			if var_1_1.chessId == AutoChessConst.BRAHMA_BOSS_ID then
				var_1_4:PlayAnim(var_1_3, "ChessItem_Ani_bianshen_right")
				manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_role", "")
			else
				var_1_4:PlayAnim(var_1_3, "ChessItem_cx")
				manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_chess", "")
			end
		else
			arg_1_0:OnSummonAnimEnd()
		end
	end
end

function var_0_1.OnSummonAnimEnd(arg_2_0)
	arg_2_0.finishCount = arg_2_0.finishCount + 1

	if arg_2_0.finishCount == #arg_2_0.actionData.chessDataList then
		arg_2_0:Finish()
	end
end

return var_0_1
