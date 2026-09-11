local AutoChessAddBuffRenderer = class("AutoChessAddBuffRenderer", (import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")))

function AutoChessAddBuffRenderer:OnBuffInvokeAnimEnd()
	self:PlayAddBuffAnim()
end

function AutoChessAddBuffRenderer:PlayAddBuffAnim()
	self.finishCount = 0

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(self.actionData.addBuffDataList) do
		local var_2_1 = AutoChessBuffCfg[iter_2_1.targetBuffData.buffId]
		local var_2_2

		if iter_2_1.targetType == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
			var_2_0 = true
			var_2_2 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(iter_2_1.targetUid)

			local var_2_3 = AutoChessBuffCfg[iter_2_1.targetBuffData.sourceCfgId]
			local var_2_4 = var_2_1.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.UPGRADE_CHESS_WITH_SAME_ATTR

			if var_2_2 then
				local var_2_5 = var_2_4 and var_2_2:GetAnimator() or var_2_2:GetAddBuffAnimator()
				local var_2_6 = var_2_4 and "ChessItem_xs" or "ChessItem_buff"
				local var_2_7 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

				var_2_7:RegistFinishCallback(handler(self, self.OnAddBuffAnimEnd))
				var_2_7:PlayAnim(var_2_5, var_2_6)

				if not var_2_4 then
					manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_light02", "")
				end
			else
				self:OnAddBuffAnimEnd()
			end

			if var_2_1.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE and var_2_2 then
				local var_2_8 = var_2_2:GetBuffKeywordConfig(var_2_1.keyword_type)

				if var_2_8 ~= nil then
					var_2_2:AddBuff(iter_2_1.targetBuffData)
					AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR):PlayAnim(var_2_8.animator, var_2_8.appearAnimName)

					if var_2_1.keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.VENOMOUS then
						manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_effect", "")
					end
				end
			end

			if var_2_3 and var_2_3.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
				local var_2_9 = AutoChessData:GetBuffData(iter_2_1.targetBuffData.sourceUid)

				if var_2_9 then
					local var_2_10

					if var_2_9.sourceType == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
						var_2_10 = var_2_9.sourceUid or iter_2_1.targetUid
					end

					local var_2_11 = AutoChessBattleRenderer.GetInstance()
					local var_2_12 = var_2_11:GetChessItemByUniqueId(var_2_10)
					local var_2_13 = var_2_12 and var_2_12:GetBuffKeywordConfig(var_2_3.keyword_type)

					if var_2_11 ~= nil then
						AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR):PlayAnim(var_2_13.animator, var_2_13.useAnimName)

						if not string.isNullOrEmpty(var_2_13.useAnimSoundEffect) then
							manager.audio:PlayEffect("minigame_activity_4_5", var_2_13.useAnimSoundEffect, "")
						end
					end
				end
			end
		end

		if AutoChessTools.IsPrepareStatus() and not AutoChessData:GetIsInUseProp() and AutoChessItemCfg[iter_2_1.targetBuffData.buffId] and AutoChessItemCfg[iter_2_1.targetBuffData.buffId].icon then
			AutoChessData:SetIsInUseProp(true)

			if AutoChessTools.IsTargetProp(AutoChessItemCfg[iter_2_1.targetBuffData.buffId].id) then
				if var_2_2 then
					var_2_2:PlayPropAnimator(AutoChessItemCfg[iter_2_1.targetBuffData.buffId].icon)
				end
			else
				local var_2_14 = AutoChessBattleRenderer.GetInstance():GetPrepareView()

				if var_2_14 then
					var_2_14:PlayPropAnimator(AutoChessItemCfg[iter_2_1.targetBuffData.buffId].icon)
				end
			end
		end
	end

	if not var_2_0 then
		self:OnAddBuffAnimEnd()
	end
end

function AutoChessAddBuffRenderer:OnAddBuffAnimEnd()
	self.finishCount = self.finishCount + 1

	if self.finishCount == #self.actionData.addBuffDataList then
		self.playPropId = nil

		self:Finish()
	end
end

return AutoChessAddBuffRenderer
