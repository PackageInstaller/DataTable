local var_0_0 = class("LimitTimeTaskBaseView", ReduxView)
local var_0_1 = "%s<size=60>/%s</size>"

local function var_0_2(arg_1_0)
	local var_1_0 = AssignmentCfg.get_id_list_by_activity_id[arg_1_0]

	if var_1_0 then
		local var_1_1 = var_1_0[#var_1_0]

		return TaskData2:GetTaskProgress(var_1_1), AssignmentCfg[var_1_1].need
	end
end

function var_0_0.UIName(arg_2_0)
	return LimitTimeTaskTools.GetLimitTimeTaskUIName(arg_2_0.params_.activityID)
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.mainActivityID_ = -1
	arg_4_0.subActivityIDList_ = {}
	arg_4_0.tabList_ = {}
	arg_4_0.pointItemList_ = {}
	arg_4_0.taskListModule_ = LimitTaskListModule.New(arg_4_0.taskPanelGo_)
	arg_4_0.onSubmitTaskHandle_ = handler(arg_4_0, arg_4_0.OnTaskRefresh)
	arg_4_0.onSubmitTaskListHandle_ = handler(arg_4_0, arg_4_0.OnTaskRefresh)
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnBehind(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.BindRedPoint(arg_8_0)
	return
end

function var_0_0.SetProgressString(arg_9_0)
	var_0_1 = arg_9_0
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:InitData()
	arg_10_0:InitTabList()
	arg_10_0:InitPointList()
	arg_10_0:AddEventListeners()
	arg_10_0.taskListModule_:OnEnter()
	arg_10_0:ChangeCurIndex(1)
	arg_10_0:RefreshUI()
	arg_10_0:BindRedPoint()
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.mainActivityID_ = arg_11_0.params_.activityID

	local var_11_0 = ActivityData:GetActivityData(arg_11_0.mainActivityID_)

	if ActivityData:GetActivityIsOpen(arg_11_0.mainActivityID_) then
		arg_11_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0.stopTime)
	elseif manager.time:GetServerTime() < var_11_0.startTime then
		arg_11_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0.startTime))
	elseif manager.time:GetServerTime() > var_11_0.stopTime then
		arg_11_0.timeLable_.text = GetTips("TIME_OVER")
	end

	if arg_11_0.timer_ == nil then
		arg_11_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_11_0.mainActivityID_) then
				arg_11_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0.stopTime)
			elseif manager.time:GetServerTime() < var_11_0.startTime then
				arg_11_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0.startTime))
			elseif manager.time:GetServerTime() > var_11_0.stopTime then
				arg_11_0.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_11_0.timer_:Start()
end

function var_0_0.InitTabList(arg_13_0)
	arg_13_0.subActivityIDList_ = ActivityCfg[arg_13_0.mainActivityID_].sub_activity_list

	local var_13_0 = #arg_13_0.subActivityIDList_

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.subActivityIDList_) do
		if not arg_13_0.tabList_[iter_13_0] then
			local var_13_1 = Object.Instantiate(arg_13_0.tabItemGo_, arg_13_0.tabTrans_)

			arg_13_0.tabList_[iter_13_0] = LimitTimeTaskTools.GetLimitTimeTabView(arg_13_0.mainActivityID_).New(var_13_1)
		end

		arg_13_0.tabList_[iter_13_0]:SetData(iter_13_0, iter_13_1, function(arg_14_0)
			arg_13_0:ChangeCurIndex(arg_14_0)
		end)

		if LimitTimeTaskTools.GetTabRedPointKey(arg_13_0.mainActivityID_) ~= "" then
			arg_13_0.tabList_[iter_13_0]:SetTabRedPointKey(LimitTimeTaskTools.GetTabRedPointKey(arg_13_0.mainActivityID_))
		end

		arg_13_0.tabList_[iter_13_0]:Show(true)
	end

	for iter_13_2 = var_13_0 + 1, #arg_13_0.tabList_ do
		arg_13_0.tabList_[iter_13_2]:Show(false)
	end
end

function var_0_0.InitPointList(arg_15_0)
	local var_15_0 = AssignmentCfg.get_id_list_by_activity_id[arg_15_0.mainActivityID_]

	if var_15_0 then
		local var_15_1 = #var_15_0

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if not arg_15_0.pointItemList_[iter_15_0] then
				local var_15_2 = Object.Instantiate(arg_15_0.pointItemGo_, arg_15_0.pointParentTrs_)

				arg_15_0.pointItemList_[iter_15_0] = LimitTimeTaskTools.GetLimitTimeTaskScheduleItemView(arg_15_0.mainActivityID_).New(var_15_2)
			end

			arg_15_0.pointItemList_[iter_15_0]:SetData(var_15_0[iter_15_0], function(arg_16_0)
				arg_15_0:OnClickPointReward(arg_16_0)
			end)
			arg_15_0.pointItemList_[iter_15_0]:Show(true)
		end

		for iter_15_2 = var_15_1 + 1, #arg_15_0.pointItemList_ do
			arg_15_0.pointItemList_[iter_15_2]:Show(false)
		end
	end
end

function var_0_0.OnClickPointReward(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.pointRewardData
	local var_17_1, var_17_2 = var_0_2(arg_17_0.mainActivityID_)
	local var_17_3 = AssignmentCfg[arg_17_1.taskID]

	if TaskData2:GetTaskComplete(arg_17_1.taskID) then
		ShowPopItem(POP_ITEM, {
			arg_17_1.id,
			arg_17_1.number
		})
	elseif var_17_1 >= var_17_3.need then
		arg_17_0:CheckPointReward()
	else
		ShowPopItem(POP_ITEM, {
			arg_17_1.id,
			arg_17_1.number
		})
	end
end

function var_0_0.CheckPointReward(arg_18_0)
	local var_18_0, var_18_1 = var_0_2(arg_18_0.mainActivityID_)
	local var_18_2 = {}
	local var_18_3 = #AssignmentCfg.get_id_list_by_activity_id[arg_18_0.mainActivityID_]

	for iter_18_0 = 1, var_18_3 do
		local var_18_4 = arg_18_0.pointItemList_[iter_18_0]:GetTaskID()
		local var_18_5 = AssignmentCfg[var_18_4]
		local var_18_6 = TaskData2:GetTaskComplete(var_18_4)

		if TaskData2:GetTaskProgress(var_18_4) >= var_18_5.need and not var_18_6 then
			table.insert(var_18_2, var_18_4)
		end
	end

	if #var_18_2 > 0 then
		TaskAction:SubmitTaskList(var_18_2)
	end
end

function var_0_0.UnBindRedPoint(arg_19_0)
	return
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:UnBindRedPoint()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.tabList_) do
		if iter_20_1 and iter_20_1.OnExit then
			iter_20_1:OnExit()
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.pointItemList_) do
		if iter_20_3 and iter_20_3.OnExit then
			iter_20_3:OnExit()
		end
	end

	arg_20_0.taskListModule_:OnExit()
	arg_20_0:RemoveEventListeners()
	arg_20_0:StopTimer()
end

function var_0_0.Dispose(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.tabList_) do
		if iter_21_1 and iter_21_1.Dispose then
			iter_21_1:Dispose()
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0.pointItemList_) do
		if iter_21_3 and iter_21_3.OnExit then
			iter_21_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_21_0)
	arg_21_0.taskListModule_:Dispose()
end

function var_0_0.ChangeCurIndex(arg_22_0, arg_22_1)
	if arg_22_0.index_ == arg_22_1 then
		return
	end

	arg_22_0.index_ = arg_22_1

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.tabList_) do
		iter_22_1:SetSelectedState(arg_22_1)
	end

	arg_22_0:RefreshTaskList()
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0:RefreshActivityPoint()
	arg_23_0:RefreshTaskList()
end

function var_0_0.RefreshActivityPoint(arg_24_0)
	local var_24_0, var_24_1 = var_0_2(arg_24_0.mainActivityID_)
	local var_24_2 = AssignmentCfg.get_id_list_by_activity_id[arg_24_0.mainActivityID_]
	local var_24_3 = var_24_2 and #var_24_2 or 0

	for iter_24_0 = 1, var_24_3 do
		local var_24_4 = arg_24_0.pointItemList_[iter_24_0]
		local var_24_5 = var_24_4:GetTaskID()
		local var_24_6 = AssignmentCfg[var_24_5]

		if TaskData2:GetTaskComplete(var_24_5) then
			var_24_4:RefreshCompleted(true)
			var_24_4:RefreshHighLight(false)
		elseif var_24_0 >= var_24_6.need then
			var_24_4:RefreshCompleted(false)
			var_24_4:RefreshHighLight(true)
		else
			var_24_4:RefreshCompleted(false)
			var_24_4:RefreshHighLight(false)
		end

		if iter_24_0 == 1 then
			local var_24_7 = var_24_2[iter_24_0]
			local var_24_8 = TaskData2:GetTaskProgress(var_24_7)
			local var_24_9 = AssignmentCfg[var_24_7].need

			var_24_4:RefreshSlider(var_24_8, var_24_9, TaskData2:GetTaskComplete(var_24_5))
		else
			local var_24_10 = var_24_2[iter_24_0 - 1]
			local var_24_11 = var_24_2[iter_24_0]
			local var_24_12 = math.max(0, TaskData2:GetTaskProgress(var_24_11) - AssignmentCfg[var_24_10].need)
			local var_24_13 = AssignmentCfg[var_24_11].need - AssignmentCfg[var_24_10].need

			var_24_4:RefreshSlider(var_24_12, var_24_13, TaskData2:GetTaskComplete(var_24_5))
		end
	end

	arg_24_0.progressText_.text = string.format(var_0_1, tostring(var_24_0), tostring(var_24_1))

	if arg_24_0.progressShadowText_ then
		arg_24_0.progressShadowText_.text = string.format(var_0_1, tostring(var_24_0), tostring(var_24_1))
	end

	arg_24_0.taskScheduleText_.text = LimitTimeTaskCfg[arg_24_0.mainActivityID_] and LimitTimeTaskCfg[arg_24_0.mainActivityID_].name or "缺少配置"
end

function var_0_0.RefreshTaskList(arg_25_0)
	local var_25_0 = arg_25_0.tabList_[arg_25_0.index_]

	if var_25_0 then
		local var_25_1 = var_25_0:GetActivityID()

		arg_25_0.taskListModule_:RenderView(var_25_1)
	end
end

function var_0_0.AddEventListeners(arg_26_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_26_0.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_26_0.onSubmitTaskListHandle_)
end

function var_0_0.RemoveEventListeners(arg_27_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_27_0.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_27_0.onSubmitTaskListHandle_)
	arg_27_0:RemoveAllEventListener()
end

function var_0_0.OnTaskRefresh(arg_28_0)
	arg_28_0:RefreshUI()
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()

		arg_29_0.timer_ = nil
	end
end

return var_0_0
