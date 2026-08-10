local var_0_0 = class("IndiaNianRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRewardsUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, CombineGameTaskItem)
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.taskList[arg_5_1], arg_5_0.activityId)
	arg_5_2:HideBar()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allGetBtn_, nil, function()
		local var_7_0 = TaskTools:GetCanGetActivityTaskList(arg_6_0.activityId)

		if #var_7_0 <= 0 then
			return
		end

		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			table.insert(var_7_1, iter_7_1.id)
		end

		TaskAction:SubmitTaskList(var_7_1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityId = IndiaNianData:GetActivityID()

	arg_9_0:AddEventListeners()
	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.taskList = {}

	table.insertto(arg_10_0.taskList, AssignmentCfg.get_id_list_by_activity_id[arg_10_0.activityId], 1)
	table.sort(arg_10_0.taskList, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_10_0:GetTaskStatus(arg_11_0)
		local var_11_1 = arg_10_0:GetTaskStatus(arg_11_1)

		if var_11_0 ~= var_11_1 then
			return var_11_0 < var_11_1
		end

		local var_11_2 = AssignmentCfg[arg_11_0]
		local var_11_3 = AssignmentCfg[arg_11_1]

		if var_11_2.type ~= var_11_3.type then
			return var_11_2.type < var_11_3.type
		end

		return var_11_2.id < var_11_3.id
	end)
	arg_10_0.list:StartScroll(#arg_10_0.taskList)

	local var_10_0 = TaskTools:GetCanGetActivityTaskList(arg_10_0.activityId)

	SetActive(arg_10_0.oneKeyGo_, #var_10_0 > 0)
end

function var_0_0.GetTaskStatus(arg_12_0, arg_12_1)
	local var_12_0 = AssignmentCfg[arg_12_1]
	local var_12_1 = TaskData2:GetTask(arg_12_1)

	if not var_12_1 then
		return 0
	end

	local var_12_2 = var_12_1.progress

	if var_12_1 ~= nil and TaskData2:GetTaskComplete(arg_12_1) then
		return 3
	elseif var_12_2 >= var_12_0.need then
		return 1
	else
		return 2
	end
end

function var_0_0.BindRedPoint(arg_13_0)
	return
end

function var_0_0.UnbindRedPoint(arg_14_0)
	return
end

function var_0_0.AddEventListeners(arg_15_0)
	arg_15_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_15_0:UpdateView()
	end)
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:UnbindRedPoint()
	arg_17_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.list then
		arg_19_0.list:Dispose()

		arg_19_0.list = nil
	end

	var_0_0.super.Dispose(arg_19_0)
	Object.Destroy(arg_19_0.gameObject_)
end

return var_0_0
