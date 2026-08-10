local var_0_0 = class("ActivityReforgeTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTaskUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("isShow")
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityReforgeTaskItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskList_[arg_5_1].id)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID_ = arg_6_0.params_.activityID

	arg_6_0:RefreshView()
	arg_6_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_6_0:RefreshView()
	end)
	arg_6_0:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		arg_6_0:RefreshView()
	end)
end

function var_0_0.RefreshView(arg_9_0)
	arg_9_0.taskList_ = TaskData2:GetActivityTaskSortList(arg_9_0.activityID_)

	arg_9_0.list_:StartScroll(#arg_9_0.taskList_)

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskList_) do
		local var_9_1 = AssignmentCfg[iter_9_1.id]
		local var_9_2 = TaskData2:GetTaskComplete(iter_9_1.id)

		if TaskData2:GetTaskProgress(iter_9_1.id) >= var_9_1.need and not var_9_2 then
			table.insert(var_9_0, iter_9_1.id)
		end
	end

	if #var_9_0 > 0 then
		arg_9_0.controller_:SetSelectedState("true")
	else
		arg_9_0.controller_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.AddUIListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.receiveBtn_, nil, function()
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(arg_11_0.taskList_) do
			local var_12_1 = AssignmentCfg[iter_12_1.id]
			local var_12_2 = TaskData2:GetTaskComplete(iter_12_1.id)

			if TaskData2:GetTaskProgress(iter_12_1.id) >= var_12_1.need and not var_12_2 then
				table.insert(var_12_0, iter_12_1.id)
			end
		end

		if #var_12_0 > 0 then
			TaskAction:SubmitTaskList(var_12_0)
		end
	end)
	arg_11_0:AddBtnListener(arg_11_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllEventListener()

	if arg_14_0.list_ then
		arg_14_0.list_:Dispose()

		arg_14_0.list_ = nil
	end

	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
