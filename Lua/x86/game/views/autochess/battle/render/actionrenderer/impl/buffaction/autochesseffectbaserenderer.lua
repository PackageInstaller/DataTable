local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")
local var_0_1 = class("AutoChessEffectBaseRenderer", var_0_0)

function var_0_1.OnPlay(arg_1_0)
	arg_1_0:PlayBuffInvokeAnim()
end

function var_0_1.PlayBuffInvokeAnim(arg_2_0)
	arg_2_0.invokeBuffUid = arg_2_0.actionData.buffUid
	arg_2_0.targetType, arg_2_0.targetUid = AutoChessData:GetBuffTargetInfo(arg_2_0.invokeBuffUid)

	if arg_2_0.targetType ~= AutoChessConst.BUFF_TARGET_TYPE.CHESS then
		arg_2_0:OnBuffInvokeAnimEnd()

		return
	end

	local var_2_0 = AutoChessData:GetBuffData(arg_2_0.invokeBuffUid).buffId
	local var_2_1 = AutoChessBuffCfg[var_2_0]
	local var_2_2 = arg_2_0.targetUid

	arg_2_0.invokeBuffChessItemView = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_2_2)

	if not var_2_1 or not arg_2_0.invokeBuffChessItemView then
		arg_2_0:OnBuffInvokeAnimEnd()

		return
	end

	if var_2_1.action_type == AutoChessConst.SPECIAL_BUFF_TYPE.REMOVE_CHESS_BUFF_ACTION_TYPE then
		arg_2_0:OnBuffInvokeAnimEnd()
	elseif var_2_1.keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE then
		arg_2_0:PlayDeadBuffInvokeAnim()
	else
		arg_2_0:PlayNormalBuffInvokeAnim()
	end
end

function var_0_1.PlayDeadBuffInvokeAnim(arg_3_0)
	local var_3_0 = arg_3_0.invokeBuffChessItemView:GetDeathWhispeTriggerAnimator()
	local var_3_1 = arg_3_0.invokeBuffChessItemView:GetBuffKeywordConfig(AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE).disappearAnimName
	local var_3_2 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

	var_3_2:RegistFinishCallback(function()
		AutoChessBattleRenderer.GetInstance():RemoveChessItemByUniqueId(arg_3_0.targetUid)
		arg_3_0:OnBuffInvokeAnimEnd()
	end)
	var_3_2:PlayAnim(var_3_0, var_3_1)
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_soul", "")
end

function var_0_1.PlayNormalBuffInvokeAnim(arg_5_0)
	local var_5_0 = arg_5_0.invokeBuffChessItemView:GetAnimator()
	local var_5_1 = var_5_0:GetCurrentAnimatorClipInfo(0)

	if var_5_1.Length > 0 and var_5_1[0].clip.name == "ChessItemDeadAnim" then
		arg_5_0:OnBuffInvokeAnimEnd()

		return
	end

	local var_5_2 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

	var_5_2:RegistFinishCallback(handler(arg_5_0, arg_5_0.OnBuffInvokeAnimEnd))
	var_5_2:PlayAnim(var_5_0, "ChessItem_takeseffect")
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_light01", "")
end

function var_0_1.OnBuffInvokeAnimEnd(arg_6_0)
	arg_6_0:Finish()
end

return var_0_1
