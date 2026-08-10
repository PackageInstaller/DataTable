local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")
local var_0_1 = class("AutoChessAddBuffRenderer", var_0_0)

function var_0_1.OnBuffInvokeAnimEnd(arg_1_0)
	arg_1_0:PlayAddBuffAnim()
end

function var_0_1.PlayAddBuffAnim(arg_2_0)
	arg_2_0.finishCount = 0

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.actionData.addBuffDataList) do
		local var_2_1 = iter_2_1.targetType
		local var_2_2 = iter_2_1.targetBuffData.buffId
		local var_2_3 = AutoChessBuffCfg[var_2_2]
		local var_2_4
		local var_2_5 = AutoChessItemCfg[var_2_2]

		if var_2_1 == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
			var_2_0 = true

			local var_2_6 = iter_2_1.targetUid

			var_2_4 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_2_6)

			local var_2_7 = iter_2_1.targetBuffData.sourceCfgId
			local var_2_8 = AutoChessBuffCfg[var_2_7]
			local var_2_9 = var_2_3.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.UPGRADE_CHESS_WITH_SAME_ATTR

			if var_2_4 then
				local var_2_10 = var_2_9 and var_2_4:GetAnimator() or var_2_4:GetAddBuffAnimator()
				local var_2_11 = var_2_9 and "ChessItem_xs" or "ChessItem_buff"
				local var_2_12 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

				var_2_12:RegistFinishCallback(handler(arg_2_0, arg_2_0.OnAddBuffAnimEnd))
				var_2_12:PlayAnim(var_2_10, var_2_11)

				if not var_2_9 then
					manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_light02", "")
				end
			else
				arg_2_0:OnAddBuffAnimEnd()
			end

			if var_2_3.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE and var_2_4 then
				local var_2_13 = var_2_4:GetBuffKeywordConfig(var_2_3.keyword_type)

				if var_2_13 ~= nil then
					var_2_4:AddBuff(iter_2_1.targetBuffData)
					AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR):PlayAnim(var_2_13.animator, var_2_13.appearAnimName)

					if var_2_3.keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.VENOMOUS then
						manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_effect", "")
					end
				end
			end

			if var_2_8 and var_2_8.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
				local var_2_14 = AutoChessData:GetBuffData(iter_2_1.targetBuffData.sourceUid)

				if var_2_14 then
					local var_2_15 = var_2_14.sourceType == AutoChessConst.BUFF_TARGET_TYPE.CHESS and var_2_14.sourceUid or iter_2_1.targetUid
					local var_2_16 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_2_15)
					local var_2_17 = var_2_16 and var_2_16:GetBuffKeywordConfig(var_2_8.keyword_type)

					if var_2_17 ~= nil then
						AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR):PlayAnim(var_2_17.animator, var_2_17.useAnimName)

						if not string.isNullOrEmpty(var_2_17.useAnimSoundEffect) then
							manager.audio:PlayEffect("minigame_activity_4_5", var_2_17.useAnimSoundEffect, "")
						end
					end
				end
			end
		end

		if AutoChessTools.IsPrepareStatus() and not AutoChessData:GetIsInUseProp() and var_2_5 and var_2_5.icon then
			AutoChessData:SetIsInUseProp(true)

			if AutoChessTools.IsTargetProp(var_2_5.id) then
				if var_2_4 then
					var_2_4:PlayPropAnimator(var_2_5.icon)
				end
			else
				local var_2_18 = AutoChessBattleRenderer.GetInstance():GetPrepareView()

				if var_2_18 then
					var_2_18:PlayPropAnimator(var_2_5.icon)
				end
			end
		end
	end

	if not var_2_0 then
		arg_2_0:OnAddBuffAnimEnd()
	end
end

function var_0_1.OnAddBuffAnimEnd(arg_3_0)
	arg_3_0.finishCount = arg_3_0.finishCount + 1

	if arg_3_0.finishCount == #arg_3_0.actionData.addBuffDataList then
		arg_3_0.playPropId = nil

		arg_3_0:Finish()
	end
end

return var_0_1
