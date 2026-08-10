local var_0_0 = class("ActivitySkinDrawTaskViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetTaskUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivitySkinDrawTaskItemOld)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:Refresh(arg_5_0.list_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allReceiveBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_6_0.list_) do
			local var_7_1 = iter_7_1.id
			local var_7_2 = AssignmentCfg[var_7_1]

			if iter_7_1.complete_flag < 1 and iter_7_1.progress >= var_7_2.need then
				table.insert(var_7_0, var_7_1)
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
	arg_8_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_8_0, arg_8_0.RefreshTask))
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshTask()
end

function var_0_0.RefreshTask(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.taskActivityID_ = arg_10_0.params_.taskActivityID
	arg_10_0.list_ = TaskData2:GetActivityTaskSortList(arg_10_0.taskActivityID_)

	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_)
end

function var_0_0.OnTop(arg_11_0)
	local var_11_0 = {
		BACK_BAR,
		HOME_BAR
	}
	local var_11_1 = ActivitySkinDrawToolsOld.GetTaskCurrency(arg_11_0.activityID_)

	table.insertto(var_11_0, var_11_1)
	manager.windowBar:SwitchBar(var_11_0)

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		manager.windowBar:SetBarCanClick(iter_11_1, true)
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	arg_13_0.scrollHelper_:Dispose()
	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
