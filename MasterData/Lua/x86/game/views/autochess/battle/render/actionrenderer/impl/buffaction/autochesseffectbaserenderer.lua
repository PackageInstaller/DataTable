local AutoChessEffectBaseRenderer = class("AutoChessEffectBaseRenderer", (import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")))

function AutoChessEffectBaseRenderer:OnPlay()
	self:PlayBuffInvokeAnim()
end

function AutoChessEffectBaseRenderer:PlayBuffInvokeAnim()
	self.invokeBuffUid = self.actionData.buffUid
	self.targetType, self.targetUid = AutoChessData:GetBuffTargetInfo(self.invokeBuffUid)

	if self.targetType ~= AutoChessConst.BUFF_TARGET_TYPE.CHESS then
		self:OnBuffInvokeAnimEnd()

		return
	end

	local var_2_0 = AutoChessBuffCfg[AutoChessData:GetBuffData(self.invokeBuffUid).buffId]

	self.invokeBuffChessItemView = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(self.targetUid)

	if not var_2_0 or not self.invokeBuffChessItemView then
		self:OnBuffInvokeAnimEnd()

		return
	end

	if var_2_0.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.REMOVE_CHESS_BUFF_ACTION_TYPE then
		self:OnBuffInvokeAnimEnd()
	elseif var_2_0.keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE then
		self:PlayDeadBuffInvokeAnim()
	else
		self:PlayNormalBuffInvokeAnim()
	end
end

function AutoChessEffectBaseRenderer:PlayDeadBuffInvokeAnim()
	local var_3_0 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

	var_3_0:RegistFinishCallback(function()
		AutoChessBattleRenderer.GetInstance():RemoveChessItemByUniqueId(self.targetUid)
		self:OnBuffInvokeAnimEnd()
	end)
	var_3_0:PlayAnim(self.invokeBuffChessItemView:GetDeathWhispeTriggerAnimator(), self.invokeBuffChessItemView:GetBuffKeywordConfig(AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE).disappearAnimName)
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_soul", "")
end

function AutoChessEffectBaseRenderer:PlayNormalBuffInvokeAnim()
	local var_5_0 = self.invokeBuffChessItemView:GetAnimator()
	local var_5_1 = var_5_0:GetCurrentAnimatorClipInfo(0)

	if var_5_1.Length > 0 and var_5_1[0].clip.name == "ChessItemDeadAnim" then
		self:OnBuffInvokeAnimEnd()

		return
	end

	local var_5_2 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

	var_5_2:RegistFinishCallback(handler(self, self.OnBuffInvokeAnimEnd))
	var_5_2:PlayAnim(var_5_0, "ChessItem_takeseffect")
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_light01", "")
end

function AutoChessEffectBaseRenderer:OnBuffInvokeAnimEnd()
	self:Finish()
end

return AutoChessEffectBaseRenderer
