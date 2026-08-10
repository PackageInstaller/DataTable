local var_0_0 = class("SummerChessBoardTaskBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.completeController_ = arg_1_0.controllerEx_:GetController("complete")
end

function var_0_0.OnEnter(arg_2_0)
	local var_2_0 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].activity_theme)

	manager.redPoint:bindUIandKey(arg_2_0.transform_, var_2_0)
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	local var_3_0 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].activity_theme)

	manager.redPoint:unbindUIandKey(arg_3_0.transform_, var_3_0)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/summerChessBoardTask", {})
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.phaseText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), SummerChessBoardTools.GetTaskRewardPhase())

	local var_7_0 = ItemTools.getItemNum(SummerChessBoardTools.GetPointItemID())
	local var_7_1 = SummerChessBoardTools.GetNextPhasePointValue()

	SetActive(arg_7_0.gameObject_, var_7_1 ~= 0)

	arg_7_0.exploreNumText_.text = var_7_0
	arg_7_0.nextNumText_.text = var_7_1

	arg_7_0.completeController_:SetSelectedState(tostring(var_7_1 <= var_7_0))

	arg_7_0.slider_.value = var_7_0 / var_7_1
end

return var_0_0
