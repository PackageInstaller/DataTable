local var_0_0 = class("AutoChessSkinDlcView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_5_Horus/V4_5_Horus_SkinDLCUI/V4_5_Horus_SkinDLCPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.taskList = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = string.format("item%s_", iter_4_0)

		arg_4_0.taskList[iter_4_0] = CommonActivityTaskItem.New(arg_4_0[var_4_0])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	arg_7_0.descText_.text = GetTips("AUTO_CHESS_SKIN_POP_DESC")

	arg_7_0:RefreshUI()
	arg_7_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_7_0:RefreshUI()
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = AssignmentCfg.get_id_list_by_activity_id[arg_9_0.activityID_] or {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskList) do
		if var_9_0[iter_9_0] then
			iter_9_1:RefreshTaskItem(var_9_0[iter_9_0])
		end
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllEventListener()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.taskList or {}) do
		iter_11_1:Dispose()

		iter_11_1 = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
