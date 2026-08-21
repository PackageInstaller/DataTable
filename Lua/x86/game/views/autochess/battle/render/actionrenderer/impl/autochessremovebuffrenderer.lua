local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")
local var_0_1 = class("AutoChessRemoveBuffRenderer", var_0_0)

function var_0_1.OnPlay(arg_1_0)
	arg_1_0:PlayRemoveBuffAnim()
	arg_1_0:PlayChessAttrChangeAnim()
end

function var_0_1.PlayRemoveBuffAnim(arg_2_0)
	local var_2_0 = arg_2_0.actionData.buffUid

	arg_2_0.chessBuffData = AutoChessData:GetBuffData(var_2_0)

	if arg_2_0.chessBuffData then
		local var_2_1 = arg_2_0.chessBuffData.buffId
		local var_2_2 = AutoChessBuffCfg[var_2_1]
		local var_2_3, var_2_4 = AutoChessData:GetBuffTargetInfo(var_2_0)

		if var_2_3 == AutoChessConst.BUFF_TARGET_TYPE.CHESS and var_2_2.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
			arg_2_0.chessItemView = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_2_4)

			if arg_2_0.chessItemView ~= nil and arg_2_0.chessItemView:GetBuffKeywordConfig(var_2_2.keyword_type) ~= nil then
				local var_2_5 = arg_2_0.chessItemView:GetBuffKeywordConfig(var_2_2.keyword_type)
				local var_2_6 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

				var_2_6:RegistFinishCallback(handler(arg_2_0, arg_2_0.OnKeywordAnimEnd))
				var_2_6:PlayAnim(var_2_5.animator, var_2_5.disappearAnimName)

				if var_2_2.keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.VENOMOUS then
					manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_effect", "")
				end
			else
				arg_2_0:OnKeywordAnimEnd()
			end
		else
			arg_2_0:OnKeywordAnimEnd()
		end
	else
		arg_2_0:Finish()
	end
end

function var_0_1.OnKeywordAnimEnd(arg_3_0)
	if arg_3_0.chessItemView then
		arg_3_0.chessItemView:RemoveBuff(arg_3_0.chessBuffData)
	end

	arg_3_0.chessItemView = nil
	arg_3_0.chessBuffData = nil

	arg_3_0:Finish()
end

function var_0_1.PlayChessAttrChangeAnim(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.actionData.chessAttrChangeDataList) do
		local var_4_0 = iter_4_1.chessUid
		local var_4_1 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_4_0)

		if var_4_1 then
			if iter_4_1.attrData.hp ~= 0 then
				var_4_1:UpdateHP()
			end

			if iter_4_1.attrData.atk ~= 0 then
				var_4_1:UpdateAttack()
			end
		end
	end
end

function var_0_1.OnReset(arg_5_0)
	arg_5_0.chessItemView = nil
	arg_5_0.chessBuffData = nil
end

return var_0_1
