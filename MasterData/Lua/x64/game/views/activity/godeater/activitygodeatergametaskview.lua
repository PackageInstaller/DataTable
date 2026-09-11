local ActivityGodEaterGameTaskView = class("ActivityGodEaterGameTaskView", ReduxView)

function ActivityGodEaterGameTaskView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Bounty/V4_2_GodEaterUI_Bounty_MainUI"
end

function ActivityGodEaterGameTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityGodEaterGameTaskView:Init()
	self:InitUI()

	self.list_ = {}

	self:AddUIListeners()
end

function ActivityGodEaterGameTaskView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.RefreshItem), self.uilistUilist_, GodEaterTaskItem)
end

function ActivityGodEaterGameTaskView:OnEnter()
	if self.param_ then
		self.activityID_ = self.param_.activity_id or ActivityConst.ACTIVITY_GODEATER_MAIN_KEY
	end

	local var_5_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_5_0.startTime
	self.stopTime_ = var_5_0.stopTime

	manager.redPoint:bindUIandKey(self.rewardbtnBtn_.transform, RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2)
	self:StopTimer()
	self:RefreshTaskList()
	self:RefreshTimeText()

	self.timer = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			JumpTools.OpenPageByJump("/ActivityGodEaterGameMainView", {
				activity_id = ActivityConst.ACTIVITY_GODEATER_MAIN_KEY
			})
			ShowTips(GetTips("TIME_OVER"))

			return
		end

		self:RefreshTimeText()
	end, 1)

	self.timer:Start()
end

function ActivityGodEaterGameTaskView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function ActivityGodEaterGameTaskView:OnTaskListChange()
	self:RefreshTaskList()
	GodEaterAction.UpdateRedPoint()
end

function ActivityGodEaterGameTaskView:RefreshTaskList()
	self.list_ = {}

	local var_9_0 = TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_1) or {}

	for iter_9_0, iter_9_1 in ipairs((TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_3))) do
		table.insert(var_9_0, iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs((self:SortTaskList(var_9_0))) do
		if AssignmentCfg[iter_9_3] and AssignmentCfg[iter_9_3].phase <= GodEaterData.hubLv then
			table.insert(self.list_, iter_9_3)
		end
	end

	self.uiList_:StartScroll(#self.list_)
end

function ActivityGodEaterGameTaskView:SortTaskList(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_3 = TaskData2:GetTask(iter_10_1)

		if var_10_3 and var_10_3.complete_flag == 1 then
			table.insert(var_10_2, iter_10_1)
		else
			if var_10_3 then
				if AssignmentCfg[iter_10_1].need <= (var_10_3.progress or 0) then
					table.insert(var_10_1, iter_10_1)

					goto label_10_0
				end
			end

			table.insert(var_10_0, iter_10_1)
		end

		::label_10_0::
	end

	local function var_10_5(arg_11_0, arg_11_1)
		local var_11_0 = GodEaterTool.GetTaskType(arg_11_0)
		local var_11_1 = GodEaterTool.GetTaskType(arg_11_1)

		if var_11_0 ~= var_11_1 then
			return var_11_1 < var_11_0
		end

		return arg_11_0 < arg_11_1
	end

	table.sort(var_10_0, var_10_5)
	table.sort(var_10_1, var_10_5)
	table.sort(var_10_2, var_10_5)
	table.insertto(var_10_1, var_10_0)
	table.insertto(var_10_1, var_10_2)

	return var_10_1
end

function ActivityGodEaterGameTaskView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_2")
end

function ActivityGodEaterGameTaskView:RefreshItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.list_[arg_13_1])
end

function ActivityGodEaterGameTaskView:RefreshTimeText()
	self.textimeText_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
end

function ActivityGodEaterGameTaskView:AddUIListeners()
	self:AddBtnListener(self.rewardbtnBtn_, nil, function()
		GodEaterTool.GotoMilestone(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY)
	end)
end

function ActivityGodEaterGameTaskView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityGodEaterGameTaskView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:RemoveTween()
	manager.redPoint:unbindUIandKey(self.rewardbtnBtn_.transform, RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2)
end

function ActivityGodEaterGameTaskView:RemoveTween()
	return
end

function ActivityGodEaterGameTaskView:Dispose()
	ActivityGodEaterGameTaskView.super.Dispose(self)

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end
end

return ActivityGodEaterGameTaskView
