local var_0_0 = class("SummerChessBoardExploreBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.updateActivityHandler_ = handler(arg_1_0, arg_1_0.RefreshUI)
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_2_0.updateActivityHandler_)
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_3_0.updateActivityHandler_)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.updateActivityHandler_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		local var_6_0 = AssignmentCfg[arg_5_0.taskID_]

		if var_6_0 == nil then
			return
		end

		JumpTools.JumpToPage(var_6_0.source)
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = SummerChessBoardTools.GetSummerChesssBoardTaskExploreID()

	if var_7_0 == 0 then
		SetActive(arg_7_0.gameObject_, false)

		return
	end

	SetActive(arg_7_0.gameObject_, true)

	arg_7_0.taskID_ = var_7_0

	local var_7_1 = AssignmentCfg[var_7_0]

	arg_7_0.titleText_.text = var_7_1.name
	arg_7_0.descText_.text = var_7_1.desc
end

return var_0_0
