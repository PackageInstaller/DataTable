local ActivityMemoryInfoView = class("ActivityMemoryInfoView", ReduxView)

function ActivityMemoryInfoView:UIName()
	return ActivityMemoryTools.GetInfoUIName(self.params_.activityId)
end

function ActivityMemoryInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityMemoryInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityMemoryInfoView:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.rewardCon_ = {}
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityMemoryInfoView:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction.SubmitTask(self.taskID_)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_7_0 = ActivityData:GetActivityData(self.cfg_.activity_jump_id)
		local var_7_1 = manager.time:GetServerTime()

		if var_7_1 < var_7_0.startTime then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		if var_7_0.stopTime <= var_7_1 then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(self.taskCfg_.source)
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function ActivityMemoryInfoView:OnEnter()
	self:RefreshUI()
	self:RefreshReward()
	self:RefreshState()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshState))
end

function ActivityMemoryInfoView:RefreshUI()
	self.id_ = self.params_.id
	self.activityID_ = self.params_.activityId
	self.cfg_ = SpringFestivalMemoryCfg[self.id_]
	self.taskID_ = self.cfg_.task_id
	self.taskCfg_ = AssignmentCfg[self.taskID_]

	local var_10_0 = ActivityMemoryTools.GetTaskActivityID(self.activityID_)

	self.info_ = TaskData2:GetTask(self.taskID_)
	self.desc_.text = self.cfg_.des
	self.taskDes_.text = self.taskCfg_.desc
	self.icon_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.icon)
end

function ActivityMemoryInfoView:RefreshState()
	if not self.info_ then
		self.progress_.text = 0 .. "/" .. self.taskCfg_.need

		self.stateCon_:SetSelectedState("unfinish")
	end

	self.progress_.text = ((self.info_.progress > self.taskCfg_.need or nil) and (self.taskCfg_.need or self.info_.progress)) .. "/" .. self.taskCfg_.need

	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")

		for iter_11_0, iter_11_1 in ipairs(self.rewardCon_) do
			self.rewardCon_[iter_11_0]:SetSelectedState("true")
		end
	elseif self.info_.progress >= self.taskCfg_.need then
		self.stateCon_:SetSelectedState("complete")

		for iter_11_2, iter_11_3 in ipairs(self.rewardCon_) do
			self.rewardCon_[iter_11_2]:SetSelectedState("false")
		end
	else
		self.stateCon_:SetSelectedState("unfinish")
		self.animator_:Play("IndiaRecallPopUI")

		for iter_11_4, iter_11_5 in ipairs(self.rewardCon_) do
			self.rewardCon_[iter_11_4]:SetSelectedState("false")
		end
	end
end

function ActivityMemoryInfoView:RefreshReward()
	for iter_12_0, iter_12_1 in ipairs(self.taskCfg_.reward) do
		if not self.rewardItems_[iter_12_0] then
			self.rewardItems_[iter_12_0] = RewardItem.New(self.rewardItem_, self.rewardParent_)

			self.rewardItems_[iter_12_0]:UpdateCommonItemAni()

			self.rewardCon_[iter_12_0] = ControllerUtil.GetController(self.rewardItems_[iter_12_0].transform_, "completed")
		end

		self.rewardItems_[iter_12_0]:SetData(iter_12_1)
	end

	for iter_12_2 = #self.taskCfg_.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_12_2]:Show(false)
	end
end

function ActivityMemoryInfoView:OnExit()
	self:RemoveAllEventListener()

	for iter_13_0, iter_13_1 in ipairs(self.rewardItems_) do
		iter_13_1:OnExit()
	end
end

function ActivityMemoryInfoView:Dispose()
	self:RemoveAllListeners()

	for iter_14_0, iter_14_1 in ipairs(self.rewardItems_) do
		iter_14_1:Dispose()
	end

	self.rewardItems_ = {}
	self.rewardCon_ = {}

	self.super.Dispose(self)
end

return ActivityMemoryInfoView
