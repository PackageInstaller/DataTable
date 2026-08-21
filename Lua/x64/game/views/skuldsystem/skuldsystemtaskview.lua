local var_0_0 = class("SkuldSystemTaskView", ReduxView)
local var_0_1 = {
	ActivityConst.ACTIVITY_SKULD_PLOT_TASK,
	ActivityConst.ACTIVITY_SKULD_CHALLENGE_TASK,
	ActivityConst.ACTIVITY_SKULD_PICTURE_TASK
}
local var_0_2 = 340

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_RewardLimitUI"
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

	arg_4_0.scheduleTaskItem_ = {}
	arg_4_0.scheduleTaskList_ = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK]

	for iter_4_0, iter_4_1 in pairs(arg_4_0.scheduleTaskList_) do
		local var_4_0 = GameObject.Instantiate(arg_4_0.taskRewardGo_, arg_4_0.contentTrans_)

		SetActive(var_4_0, true)

		local var_4_1 = (iter_4_0 - 1) * var_0_2

		var_4_0.transform.localPosition = Vector2(var_4_1, var_4_0.transform.localPosition.y)
		arg_4_0.scheduleTaskItem_[iter_4_0] = SkuldSystemTaskScheduleItem.New(var_4_0)

		arg_4_0.scheduleTaskItem_[iter_4_0]:SetData(iter_4_1, arg_4_0.scheduleTaskList_[iter_4_0 + 1])
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.contentTrans_)

	arg_4_0.taskList_ = LuaList.New(handler(arg_4_0, arg_4_0.OnRenderTask), arg_4_0.taskList_, SkuldSystemTaskItem)
	arg_4_0.curTaskTypeIndex_ = 1
	arg_4_0.curTaskIDList_ = AssignmentCfg.get_id_list_by_activity_id[var_0_1[arg_4_0.curTaskTypeIndex_]]

	for iter_4_2 = 1, 3 do
		arg_4_0["taskBtnController" .. iter_4_2 .. "_"] = arg_4_0["taskControllerEx" .. iter_4_2 .. "_"]:GetController("state")
	end

	arg_4_0.oneKeyController_ = arg_4_0.controllerEx_:GetController("onekey")
	arg_4_0.updateHandler_ = handler(arg_4_0, arg_4_0.RefreshTask)
end

function var_0_0.OnRenderTask(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.curTaskIDList_[arg_5_1]

	arg_5_2:RefreshTaskItem(var_5_0)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.onceBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			local var_7_0 = {}

			for iter_7_0, iter_7_1 in ipairs(arg_6_0.curTaskIDList_) do
				local var_7_1 = AssignmentCfg[iter_7_1]
				local var_7_2 = TaskData2:GetTaskComplete(iter_7_1)

				if TaskData2:GetTaskProgress(iter_7_1) >= var_7_1.need and not var_7_2 then
					table.insert(var_7_0, iter_7_1)
				end
			end

			if #var_7_0 > 0 then
				TaskAction:SubmitTaskList(var_7_0)
			end
		else
			ShowTips("TIME_OUT")
		end
	end)

	for iter_6_0 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["taskBtn" .. iter_6_0 .. "_"], nil, function()
			if arg_6_0.curTaskTypeIndex_ == iter_6_0 then
				return
			end

			arg_6_0.curTaskTypeIndex_ = iter_6_0
			arg_6_0.curTaskIDList_ = AssignmentCfg.get_id_list_by_activity_id[var_0_1[arg_6_0.curTaskTypeIndex_]]

			arg_6_0:RefreshTask()
		end)
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.curTaskTypeIndex_ = 1
	arg_9_0.curTaskIDList_ = AssignmentCfg.get_id_list_by_activity_id[var_0_1[arg_9_0.curTaskTypeIndex_]]

	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)
	local var_9_1 = var_9_0.stopTime

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
		arg_9_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_9_0.stopTime)
	elseif manager.time:GetServerTime() < var_9_0.startTime then
		arg_9_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_9_0.startTime))
	elseif manager.time:GetServerTime() > var_9_0.stopTime then
		arg_9_0.timeLable_.text = GetTips("TIME_OVER")
	end

	if arg_9_0.timer_ == nil then
		arg_9_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
				arg_9_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_9_0.stopTime)
			elseif manager.time:GetServerTime() < var_9_0.startTime then
				arg_9_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_9_0.startTime))
			elseif manager.time:GetServerTime() > var_9_0.stopTime then
				arg_9_0.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_9_0.timer_:Start()

	arg_9_0.taskText1_.text = GetTips("SKULD_SYSTEM_ACTIVITY_POLT_TASK_NAME")
	arg_9_0.taskText2_.text = GetTips("SKULD_SYSTEM_ACTIVITY_CHALLENGE_TASK_NAME")
	arg_9_0.taskText3_.text = GetTips("SKULD_SYSTEM_ACTIVITY_PICTURE_TASK_NAME")
	arg_9_0.taskScheduleText_.text = GetTips("SKULD_SYSTEM_TASK_SCHEDULE")

	arg_9_0:RefreshTask()

	for iter_9_0 = 1, 3 do
		local var_9_2 = var_0_1[iter_9_0]
		local var_9_3 = RedPointConst.SKULD_SYSTEM_TASK_TAG .. var_9_2

		manager.redPoint:bindUIandKey(arg_9_0["taskBtn" .. iter_9_0 .. "_"].transform, var_9_3)
	end

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_9_0.updateHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_9_0.updateHandler_)
end

function var_0_0.SortCurTaskList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.curTaskIDList_) do
		local var_11_4 = AssignmentCfg[iter_11_1]
		local var_11_5 = TaskData2:GetTaskProgress(iter_11_1)

		if TaskData2:GetTaskComplete(iter_11_1) then
			table.insert(var_11_3, iter_11_1)
		elseif var_11_5 >= var_11_4.need then
			table.insert(var_11_1, iter_11_1)
		else
			table.insert(var_11_2, iter_11_1)
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_1) do
		table.insert(var_11_0, iter_11_3)
	end

	for iter_11_4, iter_11_5 in pairs(var_11_2) do
		table.insert(var_11_0, iter_11_5)
	end

	for iter_11_6, iter_11_7 in pairs(var_11_3) do
		table.insert(var_11_0, iter_11_7)
	end

	arg_11_0.curTaskIDList_ = var_11_0
end

function var_0_0.RefreshTask(arg_12_0)
	local var_12_0, var_12_1 = SkuldSystemData:GetCurTaskScheduleInfo()

	arg_12_0.curTaskText_.text = var_12_0 .. "/" .. var_12_1

	arg_12_0:SortCurTaskList()
	arg_12_0.taskList_:StartScroll(#arg_12_0.curTaskIDList_)

	for iter_12_0 = 1, 3 do
		if arg_12_0.curTaskTypeIndex_ == iter_12_0 then
			arg_12_0["taskBtnController" .. iter_12_0 .. "_"]:SetSelectedState("select")
		else
			arg_12_0["taskBtnController" .. iter_12_0 .. "_"]:SetSelectedState("normal")
		end
	end

	local var_12_2 = false

	for iter_12_1, iter_12_2 in pairs(arg_12_0.curTaskIDList_) do
		local var_12_3 = AssignmentCfg[iter_12_2]

		if not (TaskData2:GetTaskProgress(iter_12_2) >= var_12_3.need) or TaskData2:GetTaskComplete(iter_12_2) then
			-- block empty
		else
			var_12_2 = true

			break
		end
	end

	if var_12_2 then
		arg_12_0.oneKeyController_:SetSelectedState("true")
	else
		arg_12_0.oneKeyController_:SetSelectedState("false")
	end

	for iter_12_3, iter_12_4 in pairs(arg_12_0.scheduleTaskList_) do
		arg_12_0.scheduleTaskItem_[iter_12_3]:SetData(iter_12_4, arg_12_0.scheduleTaskList_[iter_12_3 + 1])
	end
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	arg_14_0:StopTimer()

	local var_14_0 = arg_14_0.taskList_:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		iter_14_1:OnExit()
	end

	for iter_14_2 = 1, 3 do
		local var_14_1 = var_0_1[iter_14_2]
		local var_14_2 = RedPointConst.SKULD_SYSTEM_TASK_TAG .. var_14_1

		manager.redPoint:unbindUIandKey(arg_14_0["taskBtn" .. iter_14_2 .. "_"].transform, var_14_2)
	end

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_14_0.updateHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_14_0.updateHandler_)
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:StopTimer()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.scheduleTaskItem_) do
		iter_16_1:Dispose()
	end

	arg_16_0.scheduleTaskItem_ = {}

	if arg_16_0.taskList_ then
		arg_16_0.taskList_:Dispose()

		arg_16_0.taskList_ = nil
	end

	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
