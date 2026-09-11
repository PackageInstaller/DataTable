local ActivityQuizEnterView = class("ActivityQuizEnterView", ReduxView)

function ActivityQuizEnterView:UIName()
	return ActivityQuizTools.GetEnterUIName(self.params_.activityID)
end

function ActivityQuizEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityQuizEnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizEnterView:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.clearCon_ = ControllerUtil.GetController(self.transform_, "clear")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityQuizTaskItem)
end

function ActivityQuizEnterView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1], self.activityID_)
	arg_5_2:RefreshTime((manager.time:GetServerTime()))
end

function ActivityQuizEnterView:AddUIListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		if self:IsActivitying() and self:IsOpenTime() then
			ActivityQuizAction.StartMarch()
		end
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self.list_) do
			if iter_8_1.complete_flag < 1 and iter_8_1.progress >= AssignmentCfg[iter_8_1.id].need then
				table.insert(var_8_0, iter_8_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	self:AddBtnListener(self.tipBtn_, nil, function()
		local var_9_0 = ActivityQuizTools.GetHelpKey(self.activityID_)

		if var_9_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_9_0),
				key = var_9_0
			})
		end
	end)
end

function ActivityQuizEnterView:MuteEnterRedPoint()
	if self:IsOpenTime() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_QUIZ_OPEN .. "_" .. self.activityID_, 0)
		ActivityQuizTools.RecordAlreadyEnterThisLogin(self.activityID_)
		ActivityQuizTools.RecordAlreadyEnterTodayLocal(self.activityID_)
	end
end

function ActivityQuizEnterView:OnEnter()
	self:RegisterEvents()

	self.activityID_ = self.params_.activityID

	self:RefreshUI()
	self:MuteEnterRedPoint()
end

function ActivityQuizEnterView:RegisterEvents()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
end

function ActivityQuizEnterView:RefreshUI()
	self:RefreshActivityData()
	self:RefreshTime()
	self:RefreshTask()
end

function ActivityQuizEnterView:RefreshActivityData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.openTbl_, self.closeTbl_ = GameSetting.activity_quiz_open_time.value[1], GameSetting.activity_quiz_open_time.value[2]
	self.dayOpen_.text = string.format("%02d:%02d-%02d:%02d", self.openTbl_[1], self.openTbl_[2], self.closeTbl_[1], self.closeTbl_[2])
end

function ActivityQuizEnterView:RefreshTime()
	local var_15_0 = manager.time:GetServerTime()

	self:StopTimer()

	if var_15_0 < self.startTime_ then
		self.stateCon_:SetSelectedState("close")

		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			if self.startTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_15_0 < self.stopTime_ then
		self.stateCon_:SetSelectedState(self:IsOpenTime() and "unlock" or "close")

		self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
		self.timer_ = Timer.New(function()
			var_15_0 = manager.time:GetServerTime()

			if self.stopTime_ <= var_15_0 then
				self:StopTimer()
				self:RefreshTime()

				return
			else
				self.stateCon_:SetSelectedState(self:IsOpenTime() and "unlock" or "close")

				self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLable_.text = GetTips("TIME_OVER")

		self.stateCon_:SetSelectedState("close")
	end
end

function ActivityQuizEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityQuizEnterView:RefreshTask()
	local var_19_0 = ActivityQuizTools.GetTaskActivityID(self.activityID_)

	self.list_ = {}

	local var_19_1 = {}
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in pairs(TaskTools:GetActivityTaskList(var_19_0) or {}) do
		table.insert(var_19_1, iter_19_1)
	end

	for iter_19_2, iter_19_3 in ipairs(ActivityData:GetActivityData(var_19_0).subActivityIdList) do
		if ActivityData:GetActivityData(iter_19_3):IsActivitying() then
			for iter_19_4, iter_19_5 in pairs(TaskTools:GetActivityTaskList(iter_19_3) or {}) do
				table.insert(var_19_1, iter_19_5)
			end
		else
			for iter_19_6, iter_19_7 in ipairs(AssignmentCfg.get_id_list_by_activity_id[iter_19_3]) do
				table.insert(var_19_2, (TaskData2:ParserData({
					complete_flag = 0,
					progress = 0,
					id = iter_19_7
				})))
			end
		end
	end

	local var_19_3 = {}
	local var_19_4 = {}
	local var_19_5 = {}

	for iter_19_8, iter_19_9 in pairs(var_19_1) do
		if iter_19_9.complete_flag >= 1 then
			table.insert(var_19_5, iter_19_9)
		elseif iter_19_9.progress >= AssignmentCfg[iter_19_9.id].need then
			table.insert(var_19_3, iter_19_9)
		else
			table.insert(var_19_4, iter_19_9)
		end
	end

	local function var_19_6(arg_20_0, arg_20_1)
		if AssignmentCfg[arg_20_0.id].type ~= AssignmentCfg[arg_20_1.id].type then
			return AssignmentCfg[arg_20_0.id].type < AssignmentCfg[arg_20_1.id].type
		end

		return arg_20_0.id < arg_20_1.id
	end

	table.sort(var_19_3, var_19_6)
	table.sort(var_19_4, var_19_6)
	table.sort(var_19_5, var_19_6)
	table.sort(var_19_2, var_19_6)
	table.insertto(self.list_, var_19_3)
	table.insertto(self.list_, var_19_4)
	table.insertto(self.list_, var_19_5)
	table.insertto(self.list_, var_19_2)
	self.scrollHelper_:StartScroll(#self.list_)

	if #var_19_3 > 0 then
		self.clearCon_:SetSelectedState("true")
	else
		self.clearCon_:SetSelectedState("false")
	end

	self:StartTaskTimer()
end

function ActivityQuizEnterView:StartTaskTimer()
	self:StopTaskTimer()

	self.taskTimer_ = Timer.New(function()
		local var_22_0 = manager.time:GetServerTime()

		for iter_22_0, iter_22_1 in ipairs(self.scrollHelper_:GetItemList()) do
			iter_22_1:RefreshTime(var_22_0)
		end
	end, 1, -1)

	self.taskTimer_:Start()
end

function ActivityQuizEnterView:StopTaskTimer()
	if self.taskTimer_ then
		self.taskTimer_:Stop()

		self.taskTimer_ = nil
	end
end

function ActivityQuizEnterView:IsActivitying()
	local var_24_0 = manager.time:GetServerTime()

	if var_24_0 < self.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(self.startTime_, nil, true)))

		return false
	end

	if var_24_0 >= self.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function ActivityQuizEnterView:IsOpenTime()
	return ActivityQuizTools.IsInOpenTimeSpan()
end

function ActivityQuizEnterView:OnActivityQuizStartMarch()
	ActivityQuizTools.SetCurActivityID(self.activityID_, "qworld")
	JumpTools.OpenPageByJump("activityQuizMatchPop", {
		activityId = self.activityID_
	})
end

function ActivityQuizEnterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityQuizEnterView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityQuizEnterView:OnExit()
	self:RemoveAllListeners()
	self:StopTimer()
	self:StopTaskTimer()

	for iter_29_0, iter_29_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_29_1:OnExit()
	end
end

function ActivityQuizEnterView:Dispose()
	self:RemoveAllListeners()

	for iter_30_0, iter_30_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_30_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityQuizEnterView
