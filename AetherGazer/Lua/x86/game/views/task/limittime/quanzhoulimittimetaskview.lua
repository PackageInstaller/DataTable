local var_0_0 = class("QuanZhouLimitTimeTaskView", ReduxView)
local var_0_1 = "%s<size=60>/%s</size>"

local function var_0_2(arg_1_0)
	local var_1_0 = AssignmentCfg.get_id_list_by_activity_id[arg_1_0]
	local var_1_1 = var_1_0[#var_1_0]

	return TaskData2:GetTaskProgress(var_1_1), AssignmentCfg[var_1_1].need
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
		BACK_BAR
	})
end

function var_0_0.OnBehind(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:InitData()
	arg_7_0:InitTabList()
	arg_7_0:InitPointList()
	arg_7_0:AddEventListeners()
	arg_7_0.taskListModule_:OnEnter()
	arg_7_0:ChangeCurIndex(1)
	arg_7_0:RefreshUI()
end

function var_0_0.InitData(arg_8_0)
	arg_8_0.mainActivityID_ = arg_8_0.params_.activityID

	local var_8_0 = ActivityData:GetActivityData(arg_8_0.mainActivityID_)

	if ActivityData:GetActivityIsOpen(arg_8_0.mainActivityID_) then
		arg_8_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_8_0.stopTime)
	elseif manager.time:GetServerTime() < var_8_0.startTime then
		arg_8_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_0.startTime))
	elseif manager.time:GetServerTime() > var_8_0.stopTime then
		arg_8_0.timeLable_.text = GetTips("TIME_OVER")
	end

	if arg_8_0.timer_ == nil then
		arg_8_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_8_0.mainActivityID_) then
				if arg_8_0.timer_ == nil then
					arg_8_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_8_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_8_0.startTime then
				arg_8_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_0.startTime))
			elseif manager.time:GetServerTime() > var_8_0.stopTime then
				arg_8_0.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_8_0.timer_:Start()
end

function var_0_0.InitTabList(arg_10_0)
	arg_10_0.subActivityIDList_ = ActivityCfg[arg_10_0.mainActivityID_].sub_activity_list

	local var_10_0 = #arg_10_0.subActivityIDList_

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.subActivityIDList_) do
		if not arg_10_0.tabList_[iter_10_0] then
			local var_10_1 = Object.Instantiate(arg_10_0.tabItemGo_, arg_10_0.tabTrans_)

			arg_10_0.tabList_[iter_10_0] = LimitTimeTaskTabItem.New(var_10_1)
		end

		arg_10_0.tabList_[iter_10_0]:SetData(iter_10_0, iter_10_1, function(arg_11_0)
			arg_10_0:ChangeCurIndex(arg_11_0)
			arg_10_0:RefreshTaskList()
		end)
		arg_10_0.tabList_[iter_10_0]:Show(true)
	end

	for iter_10_2 = var_10_0 + 1, #arg_10_0.tabList_ do
		arg_10_0.tabList_[iter_10_2]:Show(false)
	end
end

function var_0_0.InitPointList(arg_12_0)
	local var_12_0 = AssignmentCfg.get_id_list_by_activity_id[arg_12_0.mainActivityID_]
	local var_12_1 = #var_12_0

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not arg_12_0.pointItemList_[iter_12_0] then
			local var_12_2 = Object.Instantiate(arg_12_0.pointItemGo_, arg_12_0.pointParentTrs_)

			arg_12_0.pointItemList_[iter_12_0] = QuanZhouTaskScheduleItem.New(var_12_2)
		end

		arg_12_0.pointItemList_[iter_12_0]:SetData(var_12_0[iter_12_0], function(arg_13_0)
			arg_12_0:OnClickPointReward(arg_13_0)
		end)
		arg_12_0.pointItemList_[iter_12_0]:Show(true)
	end

	for iter_12_2 = var_12_1 + 1, #arg_12_0.pointItemList_ do
		arg_12_0.pointItemList_[iter_12_2]:Show(false)
	end
end

function var_0_0.OnClickPointReward(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.pointRewardData
	local var_14_1, var_14_2 = var_0_2(arg_14_0.mainActivityID_)
	local var_14_3 = AssignmentCfg[arg_14_1.taskID]

	if TaskData2:GetTaskComplete(arg_14_1.taskID) then
		ShowPopItem(POP_ITEM, {
			arg_14_1.id,
			arg_14_1.number
		})
	elseif var_14_1 >= var_14_3.need then
		arg_14_0:CheckPointReward()
	else
		ShowPopItem(POP_ITEM, {
			arg_14_1.id,
			arg_14_1.number
		})
	end
end

function var_0_0.CheckPointReward(arg_15_0)
	local var_15_0, var_15_1 = var_0_2(arg_15_0.mainActivityID_)
	local var_15_2 = {}
	local var_15_3 = #AssignmentCfg.get_id_list_by_activity_id[arg_15_0.mainActivityID_]

	for iter_15_0 = 1, var_15_3 do
		local var_15_4 = arg_15_0.pointItemList_[iter_15_0]:GetTaskID()
		local var_15_5 = AssignmentCfg[var_15_4]
		local var_15_6 = TaskData2:GetTaskComplete(var_15_4)

		if TaskData2:GetTaskProgress(var_15_4) >= var_15_5.need and not var_15_6 then
			table.insert(var_15_2, var_15_4)
		end
	end

	if #var_15_2 > 0 then
		TaskAction:SubmitTaskList(var_15_2)
	end
end

function var_0_0.OnExit(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.tabList_) do
		if iter_16_1 and iter_16_1.OnExit then
			iter_16_1:OnExit()
		end
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.pointItemList_) do
		if iter_16_3 and iter_16_3.OnExit then
			iter_16_3:OnExit()
		end
	end

	arg_16_0.taskListModule_:OnExit()
	arg_16_0:RemoveEventListeners()
	arg_16_0:StopTimer()
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.tabList_) do
		if iter_17_1 and iter_17_1.Dispose then
			iter_17_1:Dispose()
		end
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.pointItemList_) do
		if iter_17_3 and iter_17_3.OnExit then
			iter_17_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_17_0)
	arg_17_0.taskListModule_:Dispose()
end

function var_0_0.ChangeCurIndex(arg_18_0, arg_18_1)
	if arg_18_0.index_ == arg_18_1 then
		return
	end

	arg_18_0.index_ = arg_18_1

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.tabList_) do
		iter_18_1:SetSelectedState(arg_18_1)
	end
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshActivityPoint()
	arg_19_0:RefreshTaskList()
end

function var_0_0.RefreshActivityPoint(arg_20_0)
	local var_20_0, var_20_1 = var_0_2(arg_20_0.mainActivityID_)
	local var_20_2 = AssignmentCfg.get_id_list_by_activity_id[arg_20_0.mainActivityID_]
	local var_20_3 = #var_20_2

	for iter_20_0 = 1, var_20_3 do
		local var_20_4 = arg_20_0.pointItemList_[iter_20_0]
		local var_20_5 = var_20_4:GetTaskID()
		local var_20_6 = AssignmentCfg[var_20_5]

		if TaskData2:GetTaskComplete(var_20_5) then
			var_20_4:RefreshCompleted(true)
			var_20_4:RefreshHighLight(false)
		elseif var_20_0 >= var_20_6.need then
			var_20_4:RefreshCompleted(false)
			var_20_4:RefreshHighLight(true)
		else
			var_20_4:RefreshCompleted(false)
			var_20_4:RefreshHighLight(false)
		end

		if iter_20_0 == 1 then
			local var_20_7 = var_20_2[iter_20_0]
			local var_20_8 = TaskData2:GetTaskProgress(var_20_7)
			local var_20_9 = AssignmentCfg[var_20_7].need

			var_20_4:RefreshSlider(var_20_8, var_20_9)
		else
			local var_20_10 = var_20_2[iter_20_0 - 1]
			local var_20_11 = var_20_2[iter_20_0]
			local var_20_12 = math.max(0, TaskData2:GetTaskProgress(var_20_11) - AssignmentCfg[var_20_10].need)
			local var_20_13 = AssignmentCfg[var_20_11].need - AssignmentCfg[var_20_10].need

			var_20_4:RefreshSlider(var_20_12, var_20_13)
		end
	end

	arg_20_0.progressText_.text = string.format(var_0_1, tostring(var_20_0), tostring(var_20_1))
	arg_20_0.progressShadowText_.text = string.format(var_0_1, tostring(var_20_0), tostring(var_20_1))
	arg_20_0.taskScheduleText_.text = GetTips("QUANZHOU_XIANSHI_TIPS")
end

function var_0_0.RefreshTaskList(arg_21_0)
	local var_21_0 = arg_21_0.tabList_[arg_21_0.index_]

	if var_21_0 then
		local var_21_1 = var_21_0:GetActivityID()

		arg_21_0.taskListModule_:RenderView(var_21_1)
	end
end

function var_0_0.AddEventListeners(arg_22_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_22_0.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_22_0.onSubmitTaskListHandle_)
end

function var_0_0.RemoveEventListeners(arg_23_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_23_0.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_23_0.onSubmitTaskListHandle_)
	arg_23_0:RemoveAllEventListener()
end

function var_0_0.OnTaskRefresh(arg_24_0)
	arg_24_0:RefreshUI()
end

function var_0_0.StopTimer(arg_25_0)
	if arg_25_0.timer_ then
		arg_25_0.timer_:Stop()

		arg_25_0.timer_ = nil
	end
end

return var_0_0
