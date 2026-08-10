local var_0_0 = import("game.views.task.limitTime.LimitTaskItem")
local var_0_1 = import("game.views.task.limitTime.LimitTimeTaskBaseScheduleItem")
local var_0_2 = import("game.views.task.limitTime.LimitTimeTaskBaseTabItem")
local var_0_3 = class("SummerRaceLimitedRewardView", ReduxView)

local function var_0_4()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_LIMIT_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local var_0_5 = (function()
	local var_2_0 = SummerRaceConst.REWARD_SUBTYPE

	return {
		var_2_0.DAILY,
		var_2_0.STAGE,
		var_2_0.ACHIEVEMENT
	}
end)()
local var_0_6 = "%s<size=60>/%s</size>"

local function var_0_7(arg_3_0)
	arg_3_0.windowBarBackHandler_ = arg_3_0.windowBarBackHandler_ or function()
		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_3_0.windowBarBackHandler_)
end

local function var_0_8(arg_5_0)
	if arg_5_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_5_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

local function var_0_9(arg_6_0)
	if arg_6_0 == nil then
		return
	end

	if arg_6_0.pageType ~= nil or arg_6_0.subType ~= nil then
		SummerRaceData:SetRewardPage(SummerRaceConst.REWARD_PAGE.LIMITED, arg_6_0.subType, true)
	end
end

local function var_0_10(arg_7_0)
	local var_7_0 = LimitTimeTaskCfg and LimitTimeTaskCfg[arg_7_0] or nil

	if var_7_0 ~= nil and var_7_0.name ~= nil then
		return GetI18NText(var_7_0.name)
	end

	local var_7_1 = ActivityCfg and ActivityCfg[arg_7_0] or nil

	if var_7_1 ~= nil and var_7_1.name ~= nil then
		return GetI18NText(var_7_1.name)
	end

	return ""
end

local function var_0_11(arg_8_0)
	local var_8_0 = AssignmentCfg.get_id_list_by_activity_id[arg_8_0]

	if type(var_8_0) == "table" and #var_8_0 > 0 then
		local var_8_1 = var_8_0[#var_8_0]
		local var_8_2 = AssignmentCfg[var_8_1]

		if var_8_2 ~= nil then
			return TaskData2:GetTaskProgress(var_8_1), var_8_2.need
		end
	end

	return 0, 0
end

local var_0_12 = {
	receive = 1,
	lock = 2,
	complete = 3
}

local function var_0_13(arg_9_0)
	local var_9_0 = AssignmentCfg.get_id_list_by_activity_id[arg_9_0] or {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_3 = AssignmentCfg[iter_9_1]
		local var_9_4 = "lock"

		if var_9_3 ~= nil then
			local var_9_5 = TaskData2:GetTaskProgress(iter_9_1)
			local var_9_6 = TaskData2:GetTaskComplete(iter_9_1)

			if var_9_5 >= var_9_3.need then
				if not var_9_6 then
					var_9_1[#var_9_1 + 1] = iter_9_1
					var_9_4 = "receive"
				else
					var_9_4 = "complete"
				end
			end
		end

		var_9_2[#var_9_2 + 1] = {
			id = iter_9_1,
			index = iter_9_0,
			state = var_9_4
		}
	end

	table.sort(var_9_2, function(arg_10_0, arg_10_1)
		local var_10_0 = var_0_12[arg_10_0.state] or var_0_12.lock
		local var_10_1 = var_0_12[arg_10_1.state] or var_0_12.lock

		if var_10_0 ~= var_10_1 then
			return var_10_0 < var_10_1
		end

		return arg_10_0.id < arg_10_1.id
	end)

	return var_9_1, var_9_2, 1
end

function var_0_3.UIName(arg_11_0)
	return "Widget/System/Activity_SummerRace/com/Activity_SummerRace_QuestUIVariant"
end

function var_0_3.UIParent(arg_12_0)
	return manager.ui.uiMain.transform
end

function var_0_3.Init(arg_13_0)
	arg_13_0:BindCfgUI()

	arg_13_0.taskLuaList_ = LuaList.New(handler(arg_13_0, arg_13_0.IndexTaskItem), arg_13_0.taskList_, var_0_0)
	arg_13_0.oneClickController_ = arg_13_0.controllers_ and arg_13_0.controllers_:GetController("oneclick") or nil
	arg_13_0.tabList_ = {}
	arg_13_0.pointItemList_ = {}
	arg_13_0.receiveList_ = {}
	arg_13_0.showIdList_ = {}
	arg_13_0.topIndex_ = 1
	arg_13_0.onTaskRefreshHandler_ = handler(arg_13_0, arg_13_0.RefreshView)

	arg_13_0:AddUIListener()
end

function var_0_3.AddUIListener(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.oneClickBtn_, nil, function()
		if #arg_14_0.receiveList_ > 0 then
			TaskAction:SubmitTaskList(arg_14_0.receiveList_)
		end
	end)
end

function var_0_3.OnEnter(arg_16_0)
	var_0_9(arg_16_0.params_)
	arg_16_0:UpdateBar()
	manager.redPoint:bindUIandKey(arg_16_0.oneClickBtn_.transform, var_0_4())
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_16_0.onTaskRefreshHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_16_0.onTaskRefreshHandler_)
	arg_16_0:RefreshView()
end

function var_0_3.OnTop(arg_17_0)
	arg_17_0:UpdateBar()
end

function var_0_3.UpdateBar(arg_18_0)
	var_0_7(arg_18_0)
end

function var_0_3.OnExit(arg_19_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_19_0.onTaskRefreshHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_19_0.onTaskRefreshHandler_)
	manager.redPoint:unbindUIandKey(arg_19_0.oneClickBtn_.transform, var_0_4())
	arg_19_0:StopTimer()
	var_0_8(arg_19_0)
end

function var_0_3.RefreshView(arg_20_0)
	SummerRaceData:RefreshFrameworkRedPoints()

	arg_20_0.rootActivityId_ = SummerRaceData:GetRewardRootActivityId()
	arg_20_0.subType_ = select(2, SummerRaceData:GetRewardPageSelection()) or SummerRaceConst.REWARD_SUBTYPE.DAILY

	arg_20_0:RefreshTimeLabel()
	arg_20_0:RefreshTabList()
	arg_20_0:RefreshPointList()
	arg_20_0:RefreshProgress()
	arg_20_0:RefreshTaskList()
end

function var_0_3.RefreshTimeLabel(arg_21_0)
	local var_21_0 = ActivityData:GetActivityData(arg_21_0.rootActivityId_)

	if var_21_0 == nil or arg_21_0.timeLable_ == nil then
		return
	end

	local function var_21_1()
		if ActivityData:GetActivityIsOpen(arg_21_0.rootActivityId_) then
			arg_21_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_21_0.stopTime)
		elseif manager.time:GetServerTime() < var_21_0.startTime then
			arg_21_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_21_0.startTime))
		else
			arg_21_0.timeLable_.text = GetTips("TIME_OVER")
		end
	end

	var_21_1()

	if arg_21_0.timer_ == nil then
		arg_21_0.timer_ = Timer.New(var_21_1, 1, -1)
	end

	arg_21_0.timer_:Start()
end

function var_0_3.StopTimer(arg_23_0)
	if arg_23_0.timer_ ~= nil then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

function var_0_3.GetCurrentTabIndex(arg_24_0)
	for iter_24_0 = 1, #var_0_5 do
		if var_0_5[iter_24_0] == arg_24_0.subType_ then
			return iter_24_0
		end
	end

	return 1
end

function var_0_3.RefreshTabList(arg_25_0)
	local var_25_0 = ActivityCfg[arg_25_0.rootActivityId_] and ActivityCfg[arg_25_0.rootActivityId_].sub_activity_list or {}
	local var_25_1 = #var_25_0
	local var_25_2 = arg_25_0:GetCurrentTabIndex()

	for iter_25_0 = 1, var_25_1 do
		if arg_25_0.tabList_[iter_25_0] == nil then
			local var_25_3 = Object.Instantiate(arg_25_0.tabItemGo_, arg_25_0.tabTrans_)

			arg_25_0.tabList_[iter_25_0] = var_0_2.New(var_25_3)
		end

		arg_25_0.tabList_[iter_25_0]:SetData(iter_25_0, var_25_0[iter_25_0], function(arg_26_0)
			arg_25_0:ChangeSubType(var_0_5[arg_26_0] or SummerRaceConst.REWARD_SUBTYPE.DAILY)
		end)
		arg_25_0.tabList_[iter_25_0]:SetTabRedPointKey(RedPointConst.SUMMER_RACE_LIMIT_TASK_TAG)
		arg_25_0.tabList_[iter_25_0]:SetSelectedState(var_25_2)
		arg_25_0.tabList_[iter_25_0]:Show(true)
	end

	for iter_25_1 = var_25_1 + 1, #arg_25_0.tabList_ do
		arg_25_0.tabList_[iter_25_1]:Show(false)
	end
end

function var_0_3.RefreshPointList(arg_27_0)
	local var_27_0 = AssignmentCfg.get_id_list_by_activity_id[arg_27_0.rootActivityId_] or {}
	local var_27_1 = #var_27_0

	for iter_27_0 = 1, var_27_1 do
		if arg_27_0.pointItemList_[iter_27_0] == nil then
			local var_27_2 = Object.Instantiate(arg_27_0.pointItemGo_, arg_27_0.pointParentTrs_)

			arg_27_0.pointItemList_[iter_27_0] = var_0_1.New(var_27_2)
		end

		arg_27_0.pointItemList_[iter_27_0]:SetData(var_27_0[iter_27_0], function(arg_28_0)
			arg_27_0:OnClickPointReward(arg_28_0)
		end)
		arg_27_0.pointItemList_[iter_27_0]:Show(true)
	end

	for iter_27_1 = var_27_1 + 1, #arg_27_0.pointItemList_ do
		arg_27_0.pointItemList_[iter_27_1]:Show(false)
	end
end

function var_0_3.RefreshProgress(arg_29_0)
	local var_29_0, var_29_1 = var_0_11(arg_29_0.rootActivityId_)
	local var_29_2 = AssignmentCfg.get_id_list_by_activity_id[arg_29_0.rootActivityId_] or {}

	for iter_29_0 = 1, #var_29_2 do
		local var_29_3 = arg_29_0.pointItemList_[iter_29_0]
		local var_29_4 = var_29_2[iter_29_0]
		local var_29_5 = AssignmentCfg[var_29_4]

		if var_29_3 ~= nil and var_29_5 ~= nil then
			local var_29_6 = TaskData2:GetTaskComplete(var_29_4)

			if var_29_6 then
				var_29_3:RefreshCompleted(true)
				var_29_3:RefreshHighLight(false)
			elseif var_29_0 >= var_29_5.need then
				var_29_3:RefreshCompleted(false)
				var_29_3:RefreshHighLight(true)
			else
				var_29_3:RefreshCompleted(false)
				var_29_3:RefreshHighLight(false)
			end

			if iter_29_0 == 1 then
				var_29_3:RefreshSlider(TaskData2:GetTaskProgress(var_29_4), var_29_5.need, var_29_6)
			else
				local var_29_7 = var_29_2[iter_29_0 - 1]
				local var_29_8 = AssignmentCfg[var_29_7]

				if var_29_8 ~= nil then
					var_29_3:RefreshSlider(math.max(0, TaskData2:GetTaskProgress(var_29_4) - var_29_8.need), math.max(1, var_29_5.need - var_29_8.need), var_29_6)
				end
			end
		end
	end

	if arg_29_0.progressText_ ~= nil then
		arg_29_0.progressText_.text = string.format(var_0_6, tostring(var_29_0), tostring(var_29_1))
	end

	if arg_29_0.progressSlider_ ~= nil then
		arg_29_0.progressSlider_.value = var_29_1 > 0 and math.min(1, var_29_0 / var_29_1) or 0
	end

	if arg_29_0.taskScheduleText_ ~= nil then
		arg_29_0.taskScheduleText_.text = var_0_10(arg_29_0.rootActivityId_)
	end
end

function var_0_3.ChangeSubType(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1 or SummerRaceConst.REWARD_SUBTYPE.DAILY

	if arg_30_0.subType_ == var_30_0 then
		return
	end

	arg_30_0.subType_ = var_30_0

	SummerRaceAction.SelectRewardPage(SummerRaceConst.REWARD_PAGE.LIMITED, var_30_0)

	local var_30_1 = arg_30_0:GetCurrentTabIndex()

	for iter_30_0 = 1, #arg_30_0.tabList_ do
		arg_30_0.tabList_[iter_30_0]:SetSelectedState(var_30_1)
	end

	arg_30_0:RefreshTaskList()
end

function var_0_3.RefreshTaskList(arg_31_0)
	local var_31_0 = SummerRaceData:GetRewardActivityId(SummerRaceConst.REWARD_PAGE.LIMITED, arg_31_0.subType_)

	arg_31_0.receiveList_, arg_31_0.showIdList_, arg_31_0.topIndex_ = var_0_13(var_31_0)

	if arg_31_0.oneClickController_ ~= nil then
		arg_31_0.oneClickController_:SetSelectedState(#arg_31_0.receiveList_ > 0 and "show" or "hide")
	end

	arg_31_0.taskLuaList_:StartScroll(#arg_31_0.showIdList_, arg_31_0.topIndex_)
end

function var_0_3.IndexTaskItem(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.showIdList_[arg_32_1]

	if var_32_0 == nil then
		return
	end

	arg_32_2:RefreshTaskItem(var_32_0.id, var_32_0.index)
	arg_32_2:RefreshIndex(var_32_0.index)
end

function var_0_3.OnClickPointReward(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1 and arg_33_1.taskID or nil
	local var_33_1 = var_33_0 and AssignmentCfg[var_33_0] or nil
	local var_33_2 = select(1, var_0_11(arg_33_0.rootActivityId_))

	if var_33_0 == nil or var_33_1 == nil then
		return
	end

	if TaskData2:GetTaskComplete(var_33_0) then
		ShowPopItem(POP_ITEM, {
			arg_33_1.id,
			arg_33_1.number
		})

		return
	end

	if var_33_2 >= var_33_1.need then
		arg_33_0:ReceivePointRewards()

		return
	end

	ShowPopItem(POP_ITEM, {
		arg_33_1.id,
		arg_33_1.number
	})
end

function var_0_3.ReceivePointRewards(arg_34_0)
	local var_34_0 = AssignmentCfg.get_id_list_by_activity_id[arg_34_0.rootActivityId_] or {}
	local var_34_1 = {}

	for iter_34_0 = 1, #var_34_0 do
		local var_34_2 = var_34_0[iter_34_0]
		local var_34_3 = AssignmentCfg[var_34_2]

		if var_34_3 ~= nil then
			local var_34_4 = TaskData2:GetTaskProgress(var_34_2)
			local var_34_5 = TaskData2:GetTaskComplete(var_34_2)

			if var_34_4 >= var_34_3.need and not var_34_5 then
				var_34_1[#var_34_1 + 1] = var_34_2
			end
		end
	end

	if #var_34_1 > 0 then
		TaskAction:SubmitTaskList(var_34_1)
	end
end

function var_0_3.Dispose(arg_35_0)
	var_0_8(arg_35_0)
	arg_35_0:StopTimer()

	if arg_35_0.taskLuaList_ ~= nil then
		arg_35_0.taskLuaList_:Dispose()

		arg_35_0.taskLuaList_ = nil
	end

	for iter_35_0 = 1, #(arg_35_0.tabList_ or {}) do
		arg_35_0.tabList_[iter_35_0]:Dispose()
	end

	arg_35_0.tabList_ = nil

	for iter_35_1 = 1, #(arg_35_0.pointItemList_ or {}) do
		arg_35_0.pointItemList_[iter_35_1]:Dispose()
	end

	arg_35_0.pointItemList_ = nil
	arg_35_0.windowBarBackHandler_ = nil

	var_0_3.super.Dispose(arg_35_0)
end

return var_0_3
