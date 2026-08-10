local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.Impl.buffAction.AutoChessEffectBaseRenderer")
local var_0_1 = class("AutoChessDamageRenderer", var_0_0)

function var_0_1.OnPlay(arg_1_0)
	local var_1_0 = arg_1_0.actionData.buffUid
	local var_1_1, var_1_2 = AutoChessData:GetBuffTargetInfo(var_1_0)

	if var_1_1 == AutoChessConst.BUFF_TARGET_TYPE.CHESS then
		local var_1_3 = var_1_2
		local var_1_4 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_1_3)

		arg_1_0.invokeChessItemType = AutoChessData:GetPlayerTypeByChessUid(var_1_3)

		if var_1_4 and var_1_4.chessItemData_.attributeData.hp > 0 then
			arg_1_0.invokerChessItemIndex = var_1_4.chessItemData_.index
			arg_1_0.startGo = var_1_4.gameObject_
		else
			local var_1_5 = AutoChessData:GetChessData(var_1_3)

			if var_1_5 then
				arg_1_0.invokerChessItemIndex = var_1_5.index
				arg_1_0.startGo = AutoChessBattleRenderer.GetInstance():GetFormationItemByIndex(arg_1_0.invokeChessItemType, arg_1_0.invokerChessItemIndex).gameObject_
			end
		end
	end

	arg_1_0.playedCount = 0
	arg_1_0.moveEndCount = 0
	arg_1_0.finishCount = 0
	arg_1_0.hpChangeEndNum = 0
	arg_1_0.totalNum = #arg_1_0.actionData.targetHpChangeData
	arg_1_0.isPlayingEffectItem = false
	arg_1_0.effectItemList = {}
	arg_1_0.movetionEndHandler = handler(arg_1_0, arg_1_0.OnMotionEnd)
	arg_1_0.nextEffecHandler = handler(arg_1_0, arg_1_0.OnNextEffect)
	arg_1_0.speed = getData("AutoChess", "battleSpeed") == 1 and 2 or 1
	arg_1_0.prop = GameSetting.auto_chess_fixed_percentage.value[1] / 100

	arg_1_0:PlayBuffInvokeAnim()
end

function var_0_1.Update(arg_2_0, arg_2_1)
	if not arg_2_0.isPlayingEffectItem and arg_2_0.playedCount < arg_2_0.totalNum then
		arg_2_0.playedCount = arg_2_0.playedCount + 1

		if not arg_2_0.invokerChessItemIndex or not arg_2_0.startGo then
			arg_2_0:OnHitAnimEnd()

			return
		end

		arg_2_0.isPlayingEffectItem = true

		local var_2_0 = arg_2_0.actionData.targetHpChangeData[arg_2_0.playedCount]
		local var_2_1 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_2_0.chessUid)
		local var_2_2 = var_2_1 and var_2_1.gameObject_
		local var_2_3 = AutoChessData:GetPlayerTypeByChessUid(var_2_0.chessUid)
		local var_2_4 = true

		if var_2_1 and arg_2_0.invokeChessItemType == var_2_3 then
			if arg_2_0.invokeChessItemType == AutoChessConst.PLAYER_TYPE.SELF then
				var_2_4 = arg_2_0.invokerChessItemIndex > var_2_1.chessItemData_.index
			else
				var_2_4 = arg_2_0.invokerChessItemIndex < var_2_1.chessItemData_.index
			end
		else
			var_2_4 = arg_2_0.invokeChessItemType == AutoChessConst.PLAYER_TYPE.SELF
		end

		local var_2_5 = AutoChessBattleRenderer.GetInstance():GetBuffDamageEffectItem()

		if var_2_5 and arg_2_0.startGo and var_2_2 then
			var_2_5:SetIsFree(false)
			var_2_5:SetDir(var_2_4)
			var_2_5.motionCom_:StartMotion(arg_2_0.startGo, var_2_2, arg_2_0.speed, arg_2_0.prop, arg_2_0.nextEffecHandler, arg_2_0.movetionEndHandler)

			arg_2_0.effectItemList[arg_2_0.playedCount] = var_2_5

			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_lose", "")
		else
			arg_2_0.nextEffecHandler()
			arg_2_0.movetionEndHandler()
		end
	end

	if arg_2_0.finishCount >= arg_2_0.totalNum and arg_2_0.hpChangeEndNum >= arg_2_0.totalNum then
		arg_2_0:Finish()
	end
end

function var_0_1.OnNextEffect(arg_3_0)
	arg_3_0.isPlayingEffectItem = false
end

function var_0_1.OnMotionEnd(arg_4_0)
	arg_4_0.moveEndCount = arg_4_0.moveEndCount + 1

	local var_4_0 = arg_4_0.effectItemList[arg_4_0.moveEndCount]

	if var_4_0 then
		var_4_0:SetIsFree(true)

		arg_4_0.effectItemList[arg_4_0.moveEndCount] = nil
	end

	local var_4_1 = arg_4_0.actionData.targetHpChangeData[arg_4_0.moveEndCount]
	local var_4_2 = var_4_1.chessUid
	local var_4_3 = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(var_4_2)
	local var_4_4 = AutoChessData:GetChessData(var_4_2)

	if var_4_3 then
		var_4_3:UpdateHP(var_4_4.attributeData.hp)
		var_4_3:UpdateBigHp(var_4_1.hpChange)

		local var_4_5 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

		var_4_5:RegistFinishCallback(handler(arg_4_0, arg_4_0.OnHpChangeEnd))
		var_4_5:PlayAnim(var_4_3:GetBigHpAnim(), "U_BigHP_cx")

		local var_4_6 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

		var_4_6:PlayAnim(var_4_3:GetAnimator(), "ChessItem_hit")
		var_4_6:RegistFinishCallback(handler(arg_4_0, arg_4_0.OnHitAnimEnd))
		AutoChessBattleRenderer.GetInstance():GetBattleView():PlayShakeAnim(math.abs(var_4_1.hpChange), 0)
	else
		Debug.LogError("AutoChessDamageRenderer OnMotionEnd 找不到棋子，uid=" .. tostring(var_4_2))
		arg_4_0:OnHitAnimEnd()
	end
end

function var_0_1.OnHitAnimEnd(arg_5_0)
	arg_5_0.finishCount = arg_5_0.finishCount + 1
end

function var_0_1.OnHpChangeEnd(arg_6_0)
	arg_6_0.hpChangeEndNum = arg_6_0.hpChangeEndNum + 1
end

function var_0_1.OnReset(arg_7_0)
	if arg_7_0.effectItemList then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.effectItemList) do
			iter_7_1:SetIsFree(true)
		end

		arg_7_0.effectItemList = {}
	end
end

function var_0_1.SetSpeed(arg_8_0, arg_8_1)
	arg_8_0.speed = arg_8_1

	for iter_8_0, iter_8_1 in pairs(arg_8_0.effectItemList) do
		iter_8_1.motionCom_:SetSpeedMultiplier(arg_8_0.speed)
	end
end

function var_0_1.OnBuffInvokeAnimEnd(arg_9_0)
	return
end

return var_0_1
