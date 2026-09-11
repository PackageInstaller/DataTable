local ActivityQuizTaskItem = class("ActivityQuizTaskItem", ReduxView)

function ActivityQuizTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityQuizTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.lockCon_ = ControllerUtil.GetController(self.transform_, "lock")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "status")
end

function ActivityQuizTaskItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityQuizTaskItem:Refresh(arg_6_1, arg_6_2)
	self.info_ = arg_6_1
	self.taskID_ = arg_6_1.id
	self.activityID_ = arg_6_2
	self.cfg_ = AssignmentCfg[self.taskID_]

	self:RefreshUI()
end

function ActivityQuizTaskItem:RefreshUI()
	self:RefreshReward()
	self:RefreshTask()
	self:RefreshState()
end

function ActivityQuizTaskItem:RefreshReward()
	for iter_8_0, iter_8_1 in ipairs(self.cfg_.reward) do
		if not self.rewardItems_[iter_8_0] then
			self.rewardItems_[iter_8_0] = RewardItem.New(self.rewardItem_, self.rewardParent_)

			self.rewardItems_[iter_8_0]:UpdateCommonItemAni()
		end

		self.rewardItems_[iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #self.cfg_.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:Show(false)
	end
end

function ActivityQuizTaskItem:RefreshTask()
	self.desc_.text = self.cfg_.desc

	local var_9_0

	if self.info_.progress > self.cfg_.need then
		var_9_0 = self.cfg_.need or self.info_.progress
	end

	self.progress_.text = var_9_0 .. "/" .. self.cfg_.need
	self.slider_.value = var_9_0 / self.cfg_.need

	if self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeCon_:SetSelectedState("daily")
	else
		self.typeCon_:SetSelectedState("challenge")
	end

	self.startTime_ = ActivityData:GetActivityData(self.cfg_.activity_id).startTime
end

function ActivityQuizTaskItem:RefreshState()
	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif self.info_.progress >= self.cfg_.need then
		self.stateCon_:SetSelectedState("completed")
	else
		self.stateCon_:SetSelectedState("uncomplete")
	end
end

function ActivityQuizTaskItem:RefreshTime(arg_11_1)
	if arg_11_1 >= self.startTime_ then
		self.lockCon_:SetSelectedState("false")

		return
	end

	self.lockCon_:SetSelectedState("true")

	self.timeLable_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(self.startTime_))
end

function ActivityQuizTaskItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityQuizTaskItem:OnExit()
	for iter_13_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_13_0]:OnExit()
	end
end

function ActivityQuizTaskItem:Dispose()
	self:RemoveAllListeners()

	for iter_14_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_14_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityQuizTaskItem
