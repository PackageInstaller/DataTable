local AutoChessEffectSummonRenderer = class("AutoChessEffectSummonRenderer", (import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")))

function AutoChessEffectSummonRenderer:OnBuffInvokeAnimEnd()
	self.finishCount = 0

	local var_1_0

	if self.actionData.chessDataList then
		var_1_0 = #self.actionData.chessDataList or 0

		if var_1_0 == 0 then
			self:Finish()

			return
		end
	end

	for iter_1_0 = 1, var_1_0 do
		local var_1_1 = clone(self.actionData.chessDataList[iter_1_0])
		local var_1_2 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_1_1.uniqueId)

		if var_1_2 then
			local var_1_3 = var_1_2:GetAnimator()
			local var_1_4 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

			var_1_4:RegistFinishCallback(handler(self, self.OnSummonAnimEnd))

			if var_1_1.chessId == AutoChessConst.BRAHMA_BOSS_ID then
				var_1_4:PlayAnim(var_1_3, "ChessItem_Ani_bianshen_right")
				manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_role", "")
			else
				var_1_4:PlayAnim(var_1_3, "ChessItem_cx")
				manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_duel_chess", "")
			end
		else
			self:OnSummonAnimEnd()
		end
	end
end

function AutoChessEffectSummonRenderer:OnSummonAnimEnd()
	self.finishCount = self.finishCount + 1

	if self.finishCount == #self.actionData.chessDataList then
		self:Finish()
	end
end

return AutoChessEffectSummonRenderer
