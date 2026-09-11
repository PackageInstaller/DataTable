local QuanZhouLimitTimeTaskView = class("QuanZhouLimitTimeTaskView", ReduxView)
local var_0_1 = "%s<size=60>/%s</size>"

local function var_0_2(arg_1_0)
	local var_1_0 = AssignmentCfg.get_id_list_by_activity_id[arg_1_0][#AssignmentCfg.get_id_list_by_activity_id[arg_1_0]]

	return TaskData2:GetTaskProgress(var_1_0), AssignmentCfg[var_1_0].need
end

function QuanZhouLimitTimeTaskView:UIName()
	return LimitTimeTaskTools.GetLimitTimeTaskUIName(self.params_.activityID)
end

function QuanZhouLimitTimeTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function QuanZhouLimitTimeTaskView:Init()
	self:BindCfgUI()

	self.mainActivityID_ = -1
	self.subActivityIDList_ = {}
	self.tabList_ = {}
	self.pointItemList_ = {}
	self.taskListModule_ = LimitTaskListModule.New(self.taskPanelGo_)
	self.onSubmitTaskHandle_ = handler(self, self.OnTaskRefresh)
	self.onSubmitTaskListHandle_ = handler(self, self.OnTaskRefresh)
end

function QuanZhouLimitTimeTaskView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function QuanZhouLimitTimeTaskView:OnBehind()
	manager.windowBar:HideBar()
end

function QuanZhouLimitTimeTaskView:OnEnter()
	self:InitData()
	self:InitTabList()
	self:InitPointList()
	self:AddEventListeners()
	self.taskListModule_:OnEnter()
	self:ChangeCurIndex(1)
	self:RefreshUI()
end

function QuanZhouLimitTimeTaskView:InitData()
	self.mainActivityID_ = self.params_.activityID

	local var_8_0 = ActivityData:GetActivityData(self.mainActivityID_)

	if ActivityData:GetActivityIsOpen(self.mainActivityID_) then
		self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_8_0.stopTime)
	elseif manager.time:GetServerTime() < var_8_0.startTime then
		self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_0.startTime))
	elseif manager.time:GetServerTime() > var_8_0.stopTime then
		self.timeLable_.text = GetTips("TIME_OVER")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.mainActivityID_) then
				if self.timer_ == nil then
					self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_8_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_8_0.startTime then
				self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_0.startTime))
			elseif manager.time:GetServerTime() > var_8_0.stopTime then
				self.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.timer_:Start()
end

function QuanZhouLimitTimeTaskView:InitTabList()
	self.subActivityIDList_ = ActivityCfg[self.mainActivityID_].sub_activity_list

	for iter_10_0, iter_10_1 in ipairs(self.subActivityIDList_) do
		self.tabList_[iter_10_0] = self.tabList_[iter_10_0] or LimitTimeTaskTabItem.New((Object.Instantiate(self.tabItemGo_, self.tabTrans_)))

		self.tabList_[iter_10_0]:SetData(iter_10_0, iter_10_1, function(arg_11_0)
			self:ChangeCurIndex(arg_11_0)
			self:RefreshTaskList()
		end)
		self.tabList_[iter_10_0]:Show(true)
	end

	for iter_10_2 = #self.subActivityIDList_ + 1, #self.tabList_ do
		self.tabList_[iter_10_2]:Show(false)
	end
end

function QuanZhouLimitTimeTaskView:InitPointList()
	for iter_12_0, iter_12_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_]) do
		self.pointItemList_[iter_12_0] = self.pointItemList_[iter_12_0] or QuanZhouTaskScheduleItem.New((Object.Instantiate(self.pointItemGo_, self.pointParentTrs_)))

		self.pointItemList_[iter_12_0]:SetData(AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_][iter_12_0], function(arg_13_0)
			self:OnClickPointReward(arg_13_0)
		end)
		self.pointItemList_[iter_12_0]:Show(true)
	end

	for iter_12_2 = #AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] + 1, #self.pointItemList_ do
		self.pointItemList_[iter_12_2]:Show(false)
	end
end

function QuanZhouLimitTimeTaskView:OnClickPointReward(arg_14_1)
	local var_14_1, var_14_2 = var_0_2(self.mainActivityID_)

	if TaskData2:GetTaskComplete(arg_14_1.taskID) then
		ShowPopItem(POP_ITEM, {
			arg_14_1.id,
			arg_14_1.number
		})
	elseif var_14_1 >= AssignmentCfg[arg_14_1.taskID].need then
		self:CheckPointReward()
	else
		ShowPopItem(POP_ITEM, {
			arg_14_1.id,
			arg_14_1.number
		})
	end
end

function QuanZhouLimitTimeTaskView:CheckPointReward()
	local var_15_0, var_15_1 = var_0_2(self.mainActivityID_)
	local var_15_2 = {}

	for iter_15_0 = 1, #AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] do
		local var_15_3 = self.pointItemList_[iter_15_0]:GetTaskID()

		if TaskData2:GetTaskProgress(var_15_3) >= AssignmentCfg[var_15_3].need and not TaskData2:GetTaskComplete(var_15_3) then
			table.insert(var_15_2, var_15_3)
		end
	end

	if #var_15_2 > 0 then
		TaskAction:SubmitTaskList(var_15_2)
	end
end

function QuanZhouLimitTimeTaskView:OnExit()
	for iter_16_0, iter_16_1 in ipairs(self.tabList_) do
		if iter_16_1 and iter_16_1.OnExit then
			iter_16_1:OnExit()
		end
	end

	for iter_16_2, iter_16_3 in ipairs(self.pointItemList_) do
		if iter_16_3 and iter_16_3.OnExit then
			iter_16_3:OnExit()
		end
	end

	self.taskListModule_:OnExit()
	self:RemoveEventListeners()
	self:StopTimer()
end

function QuanZhouLimitTimeTaskView:Dispose()
	for iter_17_0, iter_17_1 in ipairs(self.tabList_) do
		if iter_17_1 and iter_17_1.Dispose then
			iter_17_1:Dispose()
		end
	end

	for iter_17_2, iter_17_3 in ipairs(self.pointItemList_) do
		if iter_17_3 and iter_17_3.OnExit then
			iter_17_3:Dispose()
		end
	end

	QuanZhouLimitTimeTaskView.super.Dispose(self)
	self.taskListModule_:Dispose()
end

function QuanZhouLimitTimeTaskView:ChangeCurIndex(arg_18_1)
	if self.index_ == arg_18_1 then
		return
	end

	self.index_ = arg_18_1

	for iter_18_0, iter_18_1 in ipairs(self.tabList_) do
		iter_18_1:SetSelectedState(arg_18_1)
	end
end

function QuanZhouLimitTimeTaskView:RefreshUI()
	self:RefreshActivityPoint()
	self:RefreshTaskList()
end

function QuanZhouLimitTimeTaskView:RefreshActivityPoint()
	local var_20_0, var_20_1 = var_0_2(self.mainActivityID_)
	local var_20_2 = AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_]

	for iter_20_0 = 1, #AssignmentCfg.get_id_list_by_activity_id[self.mainActivityID_] do
		local var_20_3 = self.pointItemList_[iter_20_0]
		local var_20_4 = self.pointItemList_[iter_20_0]:GetTaskID()

		if TaskData2:GetTaskComplete(var_20_4) then
			var_20_3:RefreshCompleted(true)
			var_20_3:RefreshHighLight(false)
		elseif var_20_0 >= AssignmentCfg[var_20_4].need then
			var_20_3:RefreshCompleted(false)
			var_20_3:RefreshHighLight(true)
		else
			var_20_3:RefreshCompleted(false)
			var_20_3:RefreshHighLight(false)
		end

		if iter_20_0 == 1 then
			var_20_3:RefreshSlider(TaskData2:GetTaskProgress(var_20_2[iter_20_0]), AssignmentCfg[var_20_2[iter_20_0]].need)
		else
			local var_20_5, var_20_6 = math.max(0, TaskData2:GetTaskProgress(var_20_2[iter_20_0]) - AssignmentCfg[var_20_2[iter_20_0 - 1]].need), AssignmentCfg[var_20_2[iter_20_0]].need

			var_20_3:RefreshSlider(var_20_5, var_20_6 - AssignmentCfg[var_20_2[iter_20_0 - 1]].need)
		end
	end

	self.progressText_.text = string.format(var_0_1, tostring(var_20_0), tostring(var_20_1))
	self.progressShadowText_.text = string.format(var_0_1, tostring(var_20_0), tostring(var_20_1))
	self.taskScheduleText_.text = GetTips("QUANZHOU_XIANSHI_TIPS")
end

function QuanZhouLimitTimeTaskView:RefreshTaskList()
	if self.tabList_[self.index_] then
		self.taskListModule_:RenderView((self.tabList_[self.index_]:GetActivityID()))
	end
end

function QuanZhouLimitTimeTaskView:AddEventListeners()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)
end

function QuanZhouLimitTimeTaskView:RemoveEventListeners()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)
	self:RemoveAllEventListener()
end

function QuanZhouLimitTimeTaskView:OnTaskRefresh()
	self:RefreshUI()
end

function QuanZhouLimitTimeTaskView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return QuanZhouLimitTimeTaskView
