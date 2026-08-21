local var_0_0 = class("SummerChessBoardTipsWindowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_LvUnlockPopUI3"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.unlockController_ = arg_3_0.controllerEx_:GetController("unlock")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chessConditionID_ = arg_4_0.params_.chessConditionID

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.fullscreenBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		local var_10_0 = ActivitySummerChessConditionCfg[arg_7_0.chessConditionID_]

		ActivityUnlockStateAction.UpdateState(arg_7_0.chessConditionID_, ActivityConst.ACTIVITY_OPERATION_KEY.HIGHT_LIGHT, 1)

		local var_10_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_10_0.activity_id][1]

		manager.redPoint:setTip(SummerChessBoardData:CallFun("GetEntryRedPointKey", var_10_0.activity_id), 0, RedPointStyle.SHOW_NEW_TAG)
		arg_7_0:Back()
		JumpTools.JumpToPage2(var_10_0.jump_system)
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ActivitySummerChessConditionCfg[arg_11_0.chessConditionID_]
	local var_11_1 = ActivityData:GetActivityData(var_11_0.activity_id)

	if manager.time:GetServerTime() < var_11_1.startTime then
		local var_11_2 = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStrWith2Unit(var_11_1.startTime))

		arg_11_0.textText_.text = string.format("「%s」%s", ActivityCfg[var_11_0.activity_id].remark, var_11_2)

		arg_11_0.unlockController_:SetSelectedState("false")
	else
		arg_11_0.textText_.text = var_11_0.unlock_text

		arg_11_0.unlockController_:SetSelectedState("true")
	end

	SetSpriteWithoutAtlasAsync(arg_11_0.image_, var_11_0.image_path)

	arg_11_0.fullscreenBtn_.interactable = false
	arg_11_0.timer_ = FrameTimer.New(function()
		local var_12_0 = arg_11_0.animator1_:GetCurrentAnimatorStateInfo(0)
		local var_12_1 = arg_11_0.animator2_:GetCurrentAnimatorStateInfo(0)

		if var_12_0.normalizedTime >= 1 and var_12_1.normalizedTime >= 1 then
			arg_11_0:StopTimer()

			arg_11_0.fullscreenBtn_.interactable = true
		end
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

return var_0_0
