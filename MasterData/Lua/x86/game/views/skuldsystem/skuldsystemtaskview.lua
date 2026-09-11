local SkuldSystemTaskView = class("SkuldSystemTaskView", ReduxView)
local var_0_1 = {
	ActivityConst.ACTIVITY_SKULD_PLOT_TASK,
	ActivityConst.ACTIVITY_SKULD_CHALLENGE_TASK,
	ActivityConst.ACTIVITY_SKULD_PICTURE_TASK
}
local var_0_2 = 340

function SkuldSystemTaskView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_RewardLimitUI"
end

function SkuldSystemTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldSystemTaskView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldSystemTaskView:InitUI()
	self:BindCfgUI()

	self.scheduleTaskItem_ = {}
	self.scheduleTaskList_ = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_SKULD_SCHEDULE_TASK]

	for iter_4_0, iter_4_1 in pairs(self.scheduleTaskList_) do
		local var_4_0 = GameObject.Instantiate(self.taskRewardGo_, self.contentTrans_)

		SetActive(var_4_0, true)

		var_4_0.transform.localPosition = Vector2((iter_4_0 - 1) * var_0_2, var_4_0.transform.localPosition.y)
		self.scheduleTaskItem_[iter_4_0] = SkuldSystemTaskScheduleItem.New(var_4_0)

		self.scheduleTaskItem_[iter_4_0]:SetData(iter_4_1, self.scheduleTaskList_[iter_4_0 + 1])
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.taskList_ = LuaList.New(handler(self, self.OnRenderTask), self.taskList_, SkuldSystemTaskItem)
	self.curTaskTypeIndex_ = 1
	self.curTaskIDList_ = AssignmentCfg.get_id_list_by_activity_id[var_0_1[self.curTaskTypeIndex_]]

	for iter_4_2 = 1, 3 do
		self["taskBtnController" .. iter_4_2 .. "_"] = self["taskControllerEx" .. iter_4_2 .. "_"]:GetController("state")
	end

	self.oneKeyController_ = self.controllerEx_:GetController("onekey")
	self.updateHandler_ = handler(self, self.RefreshTask)
end

function SkuldSystemTaskView:OnRenderTask(arg_5_1, arg_5_2)
	arg_5_2:RefreshTaskItem(self.curTaskIDList_[arg_5_1])
end

function SkuldSystemTaskView:AddUIListeners()
	self:AddBtnListener(self.onceBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			local var_7_0 = {}

			for iter_7_0, iter_7_1 in ipairs(self.curTaskIDList_) do
				if TaskData2:GetTaskProgress(iter_7_1) >= AssignmentCfg[iter_7_1].need and not TaskData2:GetTaskComplete(iter_7_1) then
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
		self:AddBtnListener(self["taskBtn" .. iter_6_0 .. "_"], nil, function()
			if self.curTaskTypeIndex_ == iter_6_0 then
				return
			end

			self.curTaskTypeIndex_ = iter_6_0
			self.curTaskIDList_ = AssignmentCfg.get_id_list_by_activity_id[var_0_1[self.curTaskTypeIndex_]]

			self:RefreshTask()
		end)
	end
end

function SkuldSystemTaskView:OnEnter()
	self.curTaskTypeIndex_ = 1
	self.curTaskIDList_ = AssignmentCfg.get_id_list_by_activity_id[var_0_1[self.curTaskTypeIndex_]]

	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
		self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_9_0.stopTime)
	elseif manager.time:GetServerTime() < var_9_0.startTime then
		self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_9_0.startTime))
	elseif manager.time:GetServerTime() > var_9_0.stopTime then
		self.timeLable_.text = GetTips("TIME_OVER")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
				self.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_9_0.stopTime)
			elseif manager.time:GetServerTime() < var_9_0.startTime then
				self.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_9_0.startTime))
			elseif manager.time:GetServerTime() > var_9_0.stopTime then
				self.timeLable_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.timer_:Start()

	self.taskText1_.text = GetTips("SKULD_SYSTEM_ACTIVITY_POLT_TASK_NAME")
	self.taskText2_.text = GetTips("SKULD_SYSTEM_ACTIVITY_CHALLENGE_TASK_NAME")
	self.taskText3_.text = GetTips("SKULD_SYSTEM_ACTIVITY_PICTURE_TASK_NAME")
	self.taskScheduleText_.text = GetTips("SKULD_SYSTEM_TASK_SCHEDULE")

	self:RefreshTask()

	for iter_9_0 = 1, 3 do
		manager.redPoint:bindUIandKey(self["taskBtn" .. iter_9_0 .. "_"].transform, RedPointConst.SKULD_SYSTEM_TASK_TAG .. var_0_1[iter_9_0])
	end

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.updateHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.updateHandler_)
end

function SkuldSystemTaskView:SortCurTaskList()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in pairs(self.curTaskIDList_) do
		local var_11_4 = TaskData2:GetTaskProgress(iter_11_1)

		if TaskData2:GetTaskComplete(iter_11_1) then
			table.insert(var_11_3, iter_11_1)
		elseif var_11_4 >= AssignmentCfg[iter_11_1].need then
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

	self.curTaskIDList_ = var_11_0
end

function SkuldSystemTaskView:RefreshTask()
	local var_12_0, var_12_1 = SkuldSystemData:GetCurTaskScheduleInfo()

	self.curTaskText_.text = var_12_0 .. "/" .. var_12_1

	self:SortCurTaskList()
	self.taskList_:StartScroll(#self.curTaskIDList_)

	for iter_12_0 = 1, 3 do
		if self.curTaskTypeIndex_ == iter_12_0 then
			self["taskBtnController" .. iter_12_0 .. "_"]:SetSelectedState("select")
		else
			self["taskBtnController" .. iter_12_0 .. "_"]:SetSelectedState("normal")
		end
	end

	local var_12_2 = false

	for iter_12_1, iter_12_2 in pairs(self.curTaskIDList_) do
		if TaskData2:GetTaskProgress(iter_12_2) < AssignmentCfg[iter_12_2].need or TaskData2:GetTaskComplete(iter_12_2) then
			-- block empty
		else
			var_12_2 = true

			break
		end
	end

	if var_12_2 then
		self.oneKeyController_:SetSelectedState("true")
	else
		self.oneKeyController_:SetSelectedState("false")
	end

	for iter_12_3, iter_12_4 in pairs(self.scheduleTaskList_) do
		self.scheduleTaskItem_[iter_12_3]:SetData(iter_12_4, self.scheduleTaskList_[iter_12_3 + 1])
	end
end

function SkuldSystemTaskView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SkuldSystemTaskView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()

	for iter_14_0, iter_14_1 in pairs((self.taskList_:GetItemList())) do
		iter_14_1:OnExit()
	end

	for iter_14_2 = 1, 3 do
		manager.redPoint:unbindUIandKey(self["taskBtn" .. iter_14_2 .. "_"].transform, RedPointConst.SKULD_SYSTEM_TASK_TAG .. var_0_1[iter_14_2])
	end

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.updateHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.updateHandler_)
end

function SkuldSystemTaskView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkuldSystemTaskView:Dispose()
	self:StopTimer()

	for iter_16_0, iter_16_1 in pairs(self.scheduleTaskItem_) do
		iter_16_1:Dispose()
	end

	self.scheduleTaskItem_ = {}

	if self.taskList_ then
		self.taskList_:Dispose()

		self.taskList_ = nil
	end

	self.super.Dispose(self)
end

return SkuldSystemTaskView
