local var_0_0 = class("EatSnakesTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameRewardPopUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.taskList_, EatSnakeTaskItem)
	arg_4_0.controller = arg_4_0.controllers_:GetController("oneclick")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.oneClickBtn_, nil, function()
		local var_6_0 = TaskTools:GetCanGetActivityTaskList(arg_5_0.activityId)

		if #var_6_0 <= 0 then
			return
		end

		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			table.insert(var_6_1, iter_6_1.id)
		end

		TaskAction:SubmitTaskList(var_6_1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.normalTaskList[arg_8_1], arg_8_1, arg_8_0.activityId)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateData()
	arg_9_0:UpdateView()
end

function var_0_0.UpdateData(arg_10_0)
	arg_10_0.stageData = EatSnakeData:GetDataByPara("stageList")
	arg_10_0.activityId = arg_10_0.params_.activityId

	arg_10_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_10_0:UpdateView()
		EatSnakeAction.UpdateRewardRedPoint()
	end)
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0.normalTaskList = TaskData2:GetActivityTaskSortList(arg_12_0.activityId)

	arg_12_0.controller:SetSelectedState(arg_12_0:GetControllerState())
	arg_12_0.list:StartScroll(#arg_12_0.normalTaskList)
end

function var_0_0.GetControllerState(arg_13_0)
	local var_13_0 = TaskTools:GetActivityTaskList(arg_13_0.activityId)

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = TaskData2:GetTaskComplete(iter_13_0)

		if TaskData2:GetTaskProgress(iter_13_0) >= AssignmentCfg[iter_13_0].need and not var_13_1 then
			return "show"
		end
	end

	return "hide"
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.list then
		arg_16_0.list:Dispose()

		arg_16_0.list = nil
	end
end

return var_0_0
