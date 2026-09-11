local LimitTaskItem = import("game.views.task.limitTime.LimitTaskItem")
local LimitTimeTaskBaseScheduleItem = import("game.views.task.limitTime.LimitTimeTaskBaseScheduleItem")
local LimitTimeTaskBaseTabItem = import("game.views.task.limitTime.LimitTimeTaskBaseTabItem")
local SummerRaceLimitedRewardView = class("SummerRaceLimitedRewardView", ReduxView)

local function var_0_4()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_LIMIT_TASK, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local var_0_5 = (function()
	return {
		SummerRaceConst.REWARD_SUBTYPE.DAILY,
		SummerRaceConst.REWARD_SUBTYPE.STAGE,
		SummerRaceConst.REWARD_SUBTYPE.ACHIEVEMENT
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
	if LimitTimeTaskCfg then
		local var_7_0 = LimitTimeTaskCfg[arg_7_0] or nil

		if var_7_0 ~= nil and var_7_0.name ~= nil then
			return GetI18NText(var_7_0.name)
		end

		if ActivityCfg then
			local var_7_1 = ActivityCfg[arg_7_0] or nil

			if var_7_1 ~= nil and var_7_1.name ~= nil then
				return GetI18NText(var_7_1.name)
			end
		end
	end

	return ""
end

local function var_0_11(arg_8_0)
	if type(AssignmentCfg.get_id_list_by_activity_id[arg_8_0]) == "table" and #AssignmentCfg.get_id_list_by_activity_id[arg_8_0] > 0 then
		if AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[arg_8_0][#AssignmentCfg.get_id_list_by_activity_id[arg_8_0]]] ~= nil then
			return TaskData2:GetTaskProgress(AssignmentCfg.get_id_list_by_activity_id[arg_8_0][#AssignmentCfg.get_id_list_by_activity_id[arg_8_0]]), AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[arg_8_0][#AssignmentCfg.get_id_list_by_activity_id[arg_8_0]]].need
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
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_9_0] or {}) do
		local var_9_3 = "lock"

		if AssignmentCfg[iter_9_1] ~= nil then
			if TaskData2:GetTaskProgress(iter_9_1) >= AssignmentCfg[iter_9_1].need then
				if not TaskData2:GetTaskComplete(iter_9_1) then
					var_9_1[#var_9_1 + 1] = iter_9_1
					var_9_3 = "receive"
				else
					var_9_3 = "complete"
				end
			end
		end

		var_9_2[#var_9_2 + 1] = {
			id = iter_9_1,
			index = iter_9_0,
			state = var_9_3
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

function SummerRaceLimitedRewardView:UIName()
	return "Widget/System/Activity_SummerRace/com/Activity_SummerRace_QuestUIVariant"
end

function SummerRaceLimitedRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerRaceLimitedRewardView:Init()
	self:BindCfgUI()

	self.taskLuaList_ = LuaList.New(handler(self, self.IndexTaskItem), self.taskList_, LimitTaskItem)
	self.oneClickController_ = self.controllers_ and self.controllers_:GetController("oneclick") or nil
	self.tabList_ = {}
	self.pointItemList_ = {}
	self.receiveList_ = {}
	self.showIdList_ = {}
	self.topIndex_ = 1
	self.onTaskRefreshHandler_ = handler(self, self.RefreshView)

	self:AddUIListener()
end

function SummerRaceLimitedRewardView:AddUIListener()
	self:AddBtnListener(self.oneClickBtn_, nil, function()
		if #self.receiveList_ > 0 then
			TaskAction:SubmitTaskList(self.receiveList_)
		end
	end)
end

function SummerRaceLimitedRewardView:OnEnter()
	var_0_9(self.params_)
	self:UpdateBar()
	manager.redPoint:bindUIandKey(self.oneClickBtn_.transform, var_0_4())
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onTaskRefreshHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onTaskRefreshHandler_)
	self:RefreshView()
end

function SummerRaceLimitedRewardView:OnTop()
	self:UpdateBar()
end

function SummerRaceLimitedRewardView:UpdateBar()
	var_0_7(self)
end

function SummerRaceLimitedRewardView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onTaskRefreshHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onTaskRefreshHandler_)
	manager.redPoint:unbindUIandKey(self.oneClickBtn_.transform, var_0_4())
	self:StopTimer()
	var_0_8(self)
end

function SummerRaceLimitedRewardView:RefreshView()
	SummerRaceData:RefreshFrameworkRedPoints()

	self.rootActivityId_ = SummerRaceData:GetRewardRootActivityId()
	self.subType_ = select(2, SummerRaceData:GetRewardPageSelection()) or SummerRaceConst.REWARD_SUBTYPE.DAILY

	self:RefreshTimeLabel()
	self:RefreshTabList()
	self:RefreshPointList()
	self:RefreshProgress()
	self:RefreshTaskList()
end

function SummerRaceLimitedRewardView:RefreshTimeLabel()
	local var_21_0 = ActivityData:GetActivityData(self.rootActivityId_)

	if var_21_0 == nil or self.timeLable_ == nil then
		return
	end

	local function var_21_1()
		self.timeLable_.text = ActivityData:GetActivityIsOpen(self.rootActivityId_) and manager.time:GetLostTimeStrWith2UnitWithPrefix(var_21_0.stopTime) or manager.time:GetServerTime() < var_21_0.startTime and string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_21_0.startTime)) or GetTips("TIME_OVER")
	end

	var_21_1()

	if self.timer_ == nil then
		self.timer_ = Timer.New(var_21_1, 1, -1)
	end

	self.timer_:Start()
end

function SummerRaceLimitedRewardView:StopTimer()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SummerRaceLimitedRewardView:GetCurrentTabIndex()
	for iter_24_0 = 1, #var_0_5 do
		if var_0_5[iter_24_0] == self.subType_ then
			return iter_24_0
		end
	end

	return 1
end

function SummerRaceLimitedRewardView:RefreshTabList()
	local var_25_0

	if ActivityCfg[self.rootActivityId_] then
		var_25_0 = ActivityCfg[self.rootActivityId_].sub_activity_list or {}
	end

	local var_25_1 = #var_25_0
	local var_25_2 = self:GetCurrentTabIndex()

	for iter_25_0 = 1, #var_25_0 do
		if self.tabList_[iter_25_0] == nil then
			self.tabList_[iter_25_0] = LimitTimeTaskBaseTabItem.New((Object.Instantiate(self.tabItemGo_, self.tabTrans_)))
		end

		self.tabList_[iter_25_0]:SetData(iter_25_0, var_25_0[iter_25_0], function(arg_26_0)
			self:ChangeSubType(var_0_5[arg_26_0] or SummerRaceConst.REWARD_SUBTYPE.DAILY)
		end)
		self.tabList_[iter_25_0]:SetTabRedPointKey(RedPointConst.SUMMER_RACE_LIMIT_TASK_TAG)
		self.tabList_[iter_25_0]:SetSelectedState(var_25_2)
		self.tabList_[iter_25_0]:Show(true)
	end

	for iter_25_1 = var_25_1 + 1, #self.tabList_ do
		self.tabList_[iter_25_1]:Show(false)
	end
end

function SummerRaceLimitedRewardView:RefreshPointList()
	local var_27_0 = AssignmentCfg.get_id_list_by_activity_id[self.rootActivityId_] or {}
	local var_27_1 = #var_27_0

	for iter_27_0 = 1, #var_27_0 do
		if self.pointItemList_[iter_27_0] == nil then
			self.pointItemList_[iter_27_0] = LimitTimeTaskBaseScheduleItem.New((Object.Instantiate(self.pointItemGo_, self.pointParentTrs_)))
		end

		self.pointItemList_[iter_27_0]:SetData(var_27_0[iter_27_0], function(arg_28_0)
			self:OnClickPointReward(arg_28_0)
		end)
		self.pointItemList_[iter_27_0]:Show(true)
	end

	for iter_27_1 = var_27_1 + 1, #self.pointItemList_ do
		self.pointItemList_[iter_27_1]:Show(false)
	end
end

function SummerRaceLimitedRewardView:RefreshProgress()
	local var_29_0, var_29_1 = var_0_11(self.rootActivityId_)
	local var_29_2 = AssignmentCfg.get_id_list_by_activity_id[self.rootActivityId_] or {}

	for iter_29_0 = 1, #var_29_2 do
		local var_29_3 = self.pointItemList_[iter_29_0]
		local var_29_4 = var_29_2[iter_29_0]
		local var_29_5 = AssignmentCfg[var_29_2[iter_29_0]]

		if self.pointItemList_[iter_29_0] ~= nil and var_29_5 ~= nil then
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
				local var_29_7 = AssignmentCfg[var_29_2[iter_29_0 - 1]]

				if AssignmentCfg[var_29_2[iter_29_0 - 1]] ~= nil then
					var_29_3:RefreshSlider(math.max(0, TaskData2:GetTaskProgress(var_29_4) - var_29_7.need), math.max(1, var_29_5.need - var_29_7.need), var_29_6)
				end
			end
		end
	end

	if self.progressText_ ~= nil then
		self.progressText_.text = string.format(var_0_6, tostring(var_29_0), tostring(var_29_1))
	end

	if self.progressSlider_ ~= nil then
		self.progressSlider_.value = var_29_1 > 0 and math.min(1, var_29_0 / var_29_1) or 0
	end

	if self.taskScheduleText_ ~= nil then
		self.taskScheduleText_.text = var_0_10(self.rootActivityId_)
	end
end

function SummerRaceLimitedRewardView:ChangeSubType(arg_30_1)
	local var_30_0 = arg_30_1 or SummerRaceConst.REWARD_SUBTYPE.DAILY

	if self.subType_ == (arg_30_1 or SummerRaceConst.REWARD_SUBTYPE.DAILY) then
		return
	end

	self.subType_ = var_30_0

	SummerRaceAction.SelectRewardPage(SummerRaceConst.REWARD_PAGE.LIMITED, var_30_0)

	local var_30_1 = self:GetCurrentTabIndex()

	for iter_30_0 = 1, #self.tabList_ do
		self.tabList_[iter_30_0]:SetSelectedState(var_30_1)
	end

	self:RefreshTaskList()
end

function SummerRaceLimitedRewardView:RefreshTaskList()
	self.receiveList_, self.showIdList_, self.topIndex_ = var_0_13((SummerRaceData:GetRewardActivityId(SummerRaceConst.REWARD_PAGE.LIMITED, self.subType_)))

	if self.oneClickController_ ~= nil then
		self.oneClickController_:SetSelectedState(#self.receiveList_ > 0 and "show" or "hide")
	end

	self.taskLuaList_:StartScroll(#self.showIdList_, self.topIndex_)
end

function SummerRaceLimitedRewardView:IndexTaskItem(arg_32_1, arg_32_2)
	if self.showIdList_[arg_32_1] == nil then
		return
	end

	arg_32_2:RefreshTaskItem(self.showIdList_[arg_32_1].id, self.showIdList_[arg_32_1].index)
	arg_32_2:RefreshIndex(self.showIdList_[arg_32_1].index)
end

function SummerRaceLimitedRewardView:OnClickPointReward(arg_33_1)
	local var_33_0

	if arg_33_1 then
		var_33_0 = arg_33_1.taskID or nil

		local var_33_1

		if var_33_0 then
			var_33_1 = AssignmentCfg[var_33_0] or nil
		end
	end

	local var_33_2 = select(1, var_0_11(self.rootActivityId_))

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
		self:ReceivePointRewards()

		return
	end

	ShowPopItem(POP_ITEM, {
		arg_33_1.id,
		arg_33_1.number
	})
end

function SummerRaceLimitedRewardView:ReceivePointRewards()
	local var_34_0 = AssignmentCfg.get_id_list_by_activity_id[self.rootActivityId_] or {}
	local var_34_1 = {}

	for iter_34_0 = 1, #var_34_0 do
		if AssignmentCfg[var_34_0[iter_34_0]] ~= nil then
			if TaskData2:GetTaskProgress(var_34_0[iter_34_0]) >= AssignmentCfg[var_34_0[iter_34_0]].need and not TaskData2:GetTaskComplete(var_34_0[iter_34_0]) then
				var_34_1[#var_34_1 + 1] = var_34_0[iter_34_0]
			end
		end
	end

	if #var_34_1 > 0 then
		TaskAction:SubmitTaskList(var_34_1)
	end
end

function SummerRaceLimitedRewardView:Dispose()
	var_0_8(self)
	self:StopTimer()

	if self.taskLuaList_ ~= nil then
		self.taskLuaList_:Dispose()

		self.taskLuaList_ = nil
	end

	for iter_35_0 = 1, #(self.tabList_ or {}) do
		self.tabList_[iter_35_0]:Dispose()
	end

	self.tabList_ = nil

	for iter_35_1 = 1, #(self.pointItemList_ or {}) do
		self.pointItemList_[iter_35_1]:Dispose()
	end

	self.pointItemList_ = nil
	self.windowBarBackHandler_ = nil

	SummerRaceLimitedRewardView.super.Dispose(self)
end

return SummerRaceLimitedRewardView
