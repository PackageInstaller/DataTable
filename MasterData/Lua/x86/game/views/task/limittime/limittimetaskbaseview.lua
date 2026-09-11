local LimitTimeTaskBaseView = class("LimitTimeTaskBaseView", ReduxView)
local var_0_1 = "%s<size=60>/%s</size>"

local function var_0_2(arg_1_0)
	if AssignmentCfg.get_id_list_by_activity_id[arg_1_0] then
		return TaskData2:GetTaskProgress(AssignmentCfg.get_id_list_by_activity_id[arg_1_0][#AssignmentCfg.get_id_list_by_activity_id[arg_1_0]]), AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[arg_1_0][#AssignmentCfg.get_id_list_by_activity_id[arg_1_0]]].need
	end
end

function LimitTimeTaskBaseView:UIName()
	return LimitTimeTaskTools.GetLimitTimeTaskUIName(self.params_.activityID)
end

function LimitTimeTaskBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function LimitTimeTaskBaseView:Init()
	self:BindCfgUI()

	self.mainActivityID_ = -1
	self.subActivityIDList_ = {}
	self.tabList_ = {}
	self.pointItemList_ = {}
	self.taskListModule_ = LimitTaskListModule.New(self.taskPanelGo_)
	self.onSubmitTaskHandle_ = handler(self, self.OnTaskRefresh)
	self.onSubmitTaskListHandle_ = handler(self, self.OnTaskRefresh)
end

function LimitTimeTaskBaseView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function LimitTimeTaskBaseView:OnBehind()
	manager.windowBar:HideBar()
end

function LimitTimeTaskBaseView:BindRedPoint()
	return
end

function LimitTimeTaskBaseView:SetProgressString()
	var_0_1 = self
end

function LimitTimeTaskBaseView:OnEnter()
	self:InitData()
	self:InitTabList()
	self:InitPointList()
	self:AddEventListeners()
	self.taskListModule_:OnEnter()
	self:ChangeCurIndex(1)
	self:RefreshUI()
	self:BindRedPoint()
end

function LimitTimeTaskBaseView:InitData()
	self.mainActivityID_ = self.params_.activityID

	local var_11_0 = ActivityData:GetActivityData(self.mainActivityID_)

	if ActivityData:GetActivityIsOpen(self.mainActivityID_) then
		self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0.stopTime)
	elseif manager.time:GetServerTime() < var_11_0.startTime then
		self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0.startTime))
	elseif manager.time:GetServerTime() > var_11_0.stopTime then
		self.timeLable_.text = GetTips("TIME_OVER")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.mainActivityID_) then
				self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0.stopTime)
			elseif manager.time:GetServerTime() < var_11_0.startTime then
				self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0.startTime))
			elseif manager.time:GetServerTime() > var_11_0.stopTime then
				self.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.timer_:Start()
end

function LimitTimeTaskBaseView:InitTabList()
	self.subActivityIDList_ = ActivityCfg[self.mainActivityID_].sub_activity_list

	for iter_13_0, iter_13_1 in ipairs(self.subActivityIDList_) do
		self.tabList_[iter_13_0] = self.tabList_[iter_13_0] or LimitTimeTaskTools.GetLimitTimeTabView(self.mainActivityID_).New((Object.Instantiate(self.tabItemGo_, self.tabTrans_)))

		self.tabList_[iter_13_0]:SetData(iter_13_0, iter_13_1, function(arg_14_0)
			self:ChangeCurIndex(arg_14_0)
		end)

		if LimitTimeTaskTools.GetTabRedPointKey(self.mainActivityID_) ~= "" then
			self.tabList_[iter_13_0]:SetTabRedPointKey(LimitTimeTaskTools.GetTabRedPointKey(self.mainActivityID_))
		end

		self.tabList_[iter_13_0]:Show(true)
	end

	for iter_13_2 = #self.subActivityIDList_ + 1, #self.tabList_ do
		self.tabList_[iter_13_2]:Show(false)
	end
end

function LimitTimeTaskBaseView:InitPointList()
	if AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] then
		for iter_15_0, iter_15_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_]) do
			self.pointItemList_[iter_15_0] = self.pointItemList_[iter_15_0] or LimitTimeTaskTools.GetLimitTimeTaskScheduleItemView(self.mainActivityID_).New((Object.Instantiate(self.pointItemGo_, self.pointParentTrs_)))

			self.pointItemList_[iter_15_0]:SetData(AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_][iter_15_0], function(arg_16_0)
				self:OnClickPointReward(arg_16_0)
			end)
			self.pointItemList_[iter_15_0]:Show(true)
		end

		for iter_15_2 = #AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] + 1, #self.pointItemList_ do
			self.pointItemList_[iter_15_2]:Show(false)
		end
	end
end

function LimitTimeTaskBaseView:OnClickPointReward(arg_17_1)
	local var_17_1, var_17_2 = var_0_2(self.mainActivityID_)

	if TaskData2:GetTaskComplete(arg_17_1.taskID) then
		ShowPopItem(POP_ITEM, {
			arg_17_1.id,
			arg_17_1.number
		})
	elseif var_17_1 >= AssignmentCfg[arg_17_1.taskID].need then
		self:CheckPointReward()
	else
		ShowPopItem(POP_ITEM, {
			arg_17_1.id,
			arg_17_1.number
		})
	end
end

function LimitTimeTaskBaseView:CheckPointReward()
	local var_18_0, var_18_1 = var_0_2(self.mainActivityID_)
	local var_18_2 = {}

	for iter_18_0 = 1, #AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] do
		local var_18_3 = self.pointItemList_[iter_18_0]:GetTaskID()

		if TaskData2:GetTaskProgress(var_18_3) >= AssignmentCfg[var_18_3].need and not TaskData2:GetTaskComplete(var_18_3) then
			table.insert(var_18_2, var_18_3)
		end
	end

	if #var_18_2 > 0 then
		TaskAction:SubmitTaskList(var_18_2)
	end
end

function LimitTimeTaskBaseView:UnBindRedPoint()
	return
end

function LimitTimeTaskBaseView:OnExit()
	self:UnBindRedPoint()

	for iter_20_0, iter_20_1 in ipairs(self.tabList_) do
		if iter_20_1 and iter_20_1.OnExit then
			iter_20_1:OnExit()
		end
	end

	for iter_20_2, iter_20_3 in ipairs(self.pointItemList_) do
		if iter_20_3 and iter_20_3.OnExit then
			iter_20_3:OnExit()
		end
	end

	self.taskListModule_:OnExit()
	self:RemoveEventListeners()
	self:StopTimer()
end

function LimitTimeTaskBaseView:Dispose()
	for iter_21_0, iter_21_1 in ipairs(self.tabList_) do
		if iter_21_1 and iter_21_1.Dispose then
			iter_21_1:Dispose()
		end
	end

	for iter_21_2, iter_21_3 in ipairs(self.pointItemList_) do
		if iter_21_3 and iter_21_3.OnExit then
			iter_21_3:Dispose()
		end
	end

	LimitTimeTaskBaseView.super.Dispose(self)
	self.taskListModule_:Dispose()
end

function LimitTimeTaskBaseView:ChangeCurIndex(arg_22_1)
	if self.index_ == arg_22_1 then
		return
	end

	self.index_ = arg_22_1

	for iter_22_0, iter_22_1 in ipairs(self.tabList_) do
		iter_22_1:SetSelectedState(arg_22_1)
	end

	self:RefreshTaskList()
end

function LimitTimeTaskBaseView:RefreshUI()
	self:RefreshActivityPoint()
	self:RefreshTaskList()
end

function LimitTimeTaskBaseView:RefreshActivityPoint()
	local var_24_0, var_24_1 = var_0_2(self.mainActivityID_)
	local var_24_2 = AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_]

	for iter_24_0 = 1, (AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] or nil) and (#var_24_2 or 0) do
		local var_24_3 = self.pointItemList_[iter_24_0]
		local var_24_4 = self.pointItemList_[iter_24_0]:GetTaskID()

		if TaskData2:GetTaskComplete(var_24_4) then
			var_24_3:RefreshCompleted(true)
			var_24_3:RefreshHighLight(false)
		elseif var_24_0 >= AssignmentCfg[var_24_4].need then
			var_24_3:RefreshCompleted(false)
			var_24_3:RefreshHighLight(true)
		else
			var_24_3:RefreshCompleted(false)
			var_24_3:RefreshHighLight(false)
		end

		if iter_24_0 == 1 then
			var_24_3:RefreshSlider(TaskData2:GetTaskProgress(var_24_2[iter_24_0]), AssignmentCfg[var_24_2[iter_24_0]].need, TaskData2:GetTaskComplete(var_24_4))
		else
			local var_24_5, var_24_6 = math.max(0, TaskData2:GetTaskProgress(var_24_2[iter_24_0]) - AssignmentCfg[var_24_2[iter_24_0 - 1]].need), AssignmentCfg[var_24_2[iter_24_0]].need

			var_24_3:RefreshSlider(var_24_5, var_24_6 - AssignmentCfg[var_24_2[iter_24_0 - 1]].need, TaskData2:GetTaskComplete(var_24_4))
		end
	end

	self.progressText_.text = string.format(var_0_1, tostring(var_24_0), tostring(var_24_1))

	if self.progressShadowText_ then
		self.progressShadowText_.text = string.format(var_0_1, tostring(var_24_0), tostring(var_24_1))
	end

	if LimitTimeTaskCfg[self.mainActivityID_] then
		self.taskScheduleText_.text = LimitTimeTaskCfg[self.mainActivityID_].name or "缺少配置"
	end
end

function LimitTimeTaskBaseView:RefreshTaskList()
	if self.tabList_[self.index_] then
		self.taskListModule_:RenderView((self.tabList_[self.index_]:GetActivityID()))
	end
end

function LimitTimeTaskBaseView:AddEventListeners()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)
end

function LimitTimeTaskBaseView:RemoveEventListeners()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)
	self:RemoveAllEventListener()
end

function LimitTimeTaskBaseView:OnTaskRefresh()
	self:RefreshUI()
end

function LimitTimeTaskBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return LimitTimeTaskBaseView
