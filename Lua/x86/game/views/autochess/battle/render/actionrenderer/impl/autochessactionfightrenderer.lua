local var_0_0 = import("game.views.autoChess.battle.render.actionRenderer.AutoChessActionBaseRenderer")
local var_0_1 = class("AutoChessActionFightRenderer", var_0_0)

function var_0_1.OnPlay(arg_1_0)
	arg_1_0.fightOver = false
	arg_1_0.hpChangeEndCount = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.actionData.fightDataList) do
		local var_1_0 = iter_1_1.chessUniquiId
		local var_1_1 = AutoChessData:GetPlayerTypeByChessUid(var_1_0)

		if var_1_1 == AutoChessConst.PLAYER_TYPE.SELF then
			arg_1_0.selfChessFightData = iter_1_1
		elseif var_1_1 == AutoChessConst.PLAYER_TYPE.OPPONENT then
			arg_1_0.opponentChessFightData = iter_1_1
		end
	end

	arg_1_0.selfChessItem = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(arg_1_0.selfChessFightData.chessUniquiId)
	arg_1_0.opponentChessItem = AutoChessBattleRenderer.GetInstance():GetChessItemByUniqueId(arg_1_0.opponentChessFightData.chessUniquiId)

	if arg_1_0.selfChessItem and arg_1_0.opponentChessItem then
		arg_1_0:PlayFightTimeline()
		arg_1_0:UpdateChessItemHp()
	end
end

function var_0_1.Update(arg_2_0, arg_2_1)
	if arg_2_0.delayHpChangeTime > 0 then
		arg_2_0.delayHpChangeTime = arg_2_0.delayHpChangeTime - arg_2_1

		if arg_2_0.delayHpChangeTime <= 0 then
			arg_2_0:PlayChessItemHpChange()
		end
	end

	if arg_2_0.fightOver and arg_2_0.hpChangeEndCount >= 2 then
		arg_2_0:Finish()
	end
end

function var_0_1.OnControllerFinish(arg_3_0)
	arg_3_0.fightOver = true
end

function var_0_1.PlayFightTimeline(arg_4_0)
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_collide", "")

	local var_4_0 = AutoChessBattleRenderer.GetInstance():GetBattleView()

	var_4_0:PlayShakeAnim(math.max(math.abs(arg_4_0.selfChessFightData.hpChange), math.abs(arg_4_0.opponentChessFightData.hpChange)), 0.2)

	local var_4_1 = var_4_0.fightDirector_
	local var_4_2 = var_4_0.fightPlayable_
	local var_4_3 = var_4_2:GetOutputTrack(0)

	var_4_1:SetGenericBinding(var_4_3, arg_4_0.selfChessItem:GetAnimator())

	local var_4_4 = var_4_2:GetOutputTrack(1)

	var_4_1:SetGenericBinding(var_4_4, arg_4_0.opponentChessItem:GetAnimator())

	local var_4_5 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.TIME_LINE)

	var_4_5:RegistFinishCallback(handler(arg_4_0, arg_4_0.OnControllerFinish))
	var_4_5:InitPlayable(var_4_1, var_4_2)
	var_4_5:Play()
end

function var_0_1.UpdateChessItemHp(arg_5_0)
	arg_5_0.delayHpChangeTime = 0.4 / AutoChessBattleRenderer.GetInstance():GetSpeed()
end

function var_0_1.PlayChessItemHpChange(arg_6_0)
	arg_6_0.selfChessItem:UpdateHP(arg_6_0.actionData.selfChessDataHp)
	arg_6_0.opponentChessItem:UpdateHP(arg_6_0.actionData.opponentChessDataHp)
	arg_6_0.selfChessItem:UpdateBigHp(arg_6_0.selfChessFightData.hpChange)
	arg_6_0.opponentChessItem:UpdateBigHp(arg_6_0.opponentChessFightData.hpChange)

	local var_6_0 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)
	local var_6_1 = AutoChessRenderControllerFactory.GetInstance():GetRenderController(AutoChessConst.ACTION_RENDER_CONTROLLER_TYPE.ANIMATOR)

	var_6_0:RegistFinishCallback(handler(arg_6_0, arg_6_0.OnHpChangeEnd))
	var_6_0:PlayAnim(arg_6_0.selfChessItem:GetBigHpAnim(), "U_BigHP_cx")
	var_6_1:RegistFinishCallback(handler(arg_6_0, arg_6_0.OnHpChangeEnd))
	var_6_1:PlayAnim(arg_6_0.opponentChessItem:GetBigHpAnim(), "U_BigHP_cx")
end

function var_0_1.OnHpChangeEnd(arg_7_0)
	arg_7_0.hpChangeEndCount = arg_7_0.hpChangeEndCount + 1
end

function var_0_1.OnFinish(arg_8_0)
	AutoChessBattleSimulator.GetInstance():GetBlackboard():SetIsFightOver()

	arg_8_0.selfChessFightData = nil
	arg_8_0.selfChessItem = nil
	arg_8_0.opponentChessFightData = nil
	arg_8_0.opponentChessItem = nil
end

return var_0_1
