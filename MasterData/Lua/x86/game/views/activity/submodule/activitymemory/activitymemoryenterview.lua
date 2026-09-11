local ActivityMemoryEnterView = class("ActivityMemoryEnterView", ReduxView)

function ActivityMemoryEnterView:UIName()
	return ActivityMemoryTools.GetEnterUIName(self.params_.activityID)
end

function ActivityMemoryEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMemoryEnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityMemoryEnterView:InitUI()
	self:BindCfgUI()

	self.taskItem_ = {}

	for iter_4_0, iter_4_1 in ipairs(SpringFestivalMemoryCfg.get_id_list_by_activity_id[self.params_.activityID]) do
		self.taskItem_[iter_4_0] = ActivityMemoryTaskItem.New(self["taskItem_" .. iter_4_0])

		self.taskItem_[iter_4_0]:SetData(iter_4_1, self.params_.activityID)
	end
end

function ActivityMemoryEnterView:AddUIListeners()
	self:AddBtnListener(self.enterStoryBtn_, nil, function()
		self:PlayStory(self.enterStoryID_)
	end)
	self:AddBtnListener(self.activityStoryBtn_, nil, function()
		self:PlayStory(self.activityStoryID_)
	end)
	self:AddBtnListener(self.collectStoryBtn_, nil, function()
		self:PlayStory(self.collectStoryID_)
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_9_0 = ActivityMemoryTools.GetHelpKey(self.activityID_)

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

function ActivityMemoryEnterView:OnEnter()
	self:RefreshUI()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. self.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_MEMORY_OPEN, tostring(self.activityID_), true)
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
end

function ActivityMemoryEnterView:RefreshUI()
	self:RefreshData()
	self:RefreshTime()
	self:RefreshTask()
	self:RefreshStory()
end

function ActivityMemoryEnterView:RefreshData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.enterStoryID_ = ActivityMemoryTools.GetEnterCondition(self.activityID_)[2]
	self.activityStoryID_ = ActivityMemoryTools.GetActivityCondition(self.activityID_)[2]
	self.collectStoryID_ = ActivityMemoryTools.GetCollectCondition(self.activityID_)[2]
end

function ActivityMemoryEnterView:RefreshTime()
	self:StopTimer()

	local var_13_0 = manager.time:GetServerTime()

	if var_13_0 < self.startTime_ then
		self.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			if manager.time:GetServerTime() >= self.startTime_ then
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_13_0 < self.stopTime_ then
		self.timeLabel_.text = manager.time:GetLostTimeStr2(self.stopTime_)
		self.timer_ = Timer.New(function()
			if manager.time:GetServerTime() >= self.stopTime_ then
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLabel_.text = GetTips("TIME_OVER")
	end
end

function ActivityMemoryEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityMemoryEnterView:RefreshTask()
	self.progress_ = 0

	local var_17_0 = ActivityMemoryTools.GetTaskActivityID(self.activityID_)

	for iter_17_0, iter_17_1 in ipairs(SpringFestivalMemoryCfg.get_id_list_by_activity_id[self.activityID_]) do
		local var_17_1 = TaskData2:GetTask(SpringFestivalMemoryCfg[iter_17_1].task_id)

		if var_17_1 and var_17_1.progress >= AssignmentCfg[SpringFestivalMemoryCfg[iter_17_1].task_id].need then
			self.progress_ = self.progress_ + 1
		end

		self.taskItem_[iter_17_0]:RefreshUI()
	end

	self.progressTxt_.text = string.format(GetTips("SPRING_FESTIVAL_MEMORY"), self.progress_, #SpringFestivalMemoryCfg.get_id_list_by_activity_id[self.activityID_])
end

function ActivityMemoryEnterView:RefreshStory()
	SetActive(self.enterStoryBtn_.gameObject, self.enterStoryID_ and manager.story:IsStoryPlayed(self.enterStoryID_))
	SetActive(self.activityStoryBtn_.gameObject, self.activityStoryID_ and manager.story:IsStoryPlayed(self.activityStoryID_))
	SetActive(self.collectStoryBtn_.gameObject, self.collectStoryID_ and manager.story:IsStoryPlayed(self.collectStoryID_))
end

function ActivityMemoryEnterView:PlayStory(arg_19_1, arg_19_2)
	manager.story:StartStoryById(arg_19_1, function()
		if arg_19_2 then
			arg_19_2()
		end
	end)
end

function ActivityMemoryEnterView:OnTop()
	self:RefreshStory()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityMemoryEnterView:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()

	for iter_22_0, iter_22_1 in ipairs(self.taskItem_) do
		iter_22_1:OnExit()
	end
end

function ActivityMemoryEnterView:Dispose()
	self:RemoveAllListeners()

	for iter_23_0, iter_23_1 in ipairs(self.taskItem_) do
		iter_23_1:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityMemoryEnterView
