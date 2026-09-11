local ActivityPushBoxRewardItem = class("ActivityPushBoxRewardItem", ReduxView)

function ActivityPushBoxRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPushBoxRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityPushBoxRewardItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityPushBoxRewardItem:Refresh(arg_6_1)
	self.info_ = arg_6_1
	self.taskID_ = arg_6_1.id
	self.cfg_ = AssignmentCfg[self.taskID_]

	self:RefreshUI()
end

function ActivityPushBoxRewardItem:RefreshUI()
	self:RefreshReward()
	self:RefreshTask()
end

function ActivityPushBoxRewardItem:RefreshReward()
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

function ActivityPushBoxRewardItem:RefreshTask()
	self.desc_.text = GetI18NText(self.cfg_.desc)

	local var_9_0

	if self.info_.progress > self.cfg_.need then
		var_9_0 = self.cfg_.need or self.info_.progress
	end

	self.progress_.text = var_9_0 .. "/" .. self.cfg_.need
	self.slider_.value = var_9_0 / self.cfg_.need

	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif self.info_.progress >= self.cfg_.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function ActivityPushBoxRewardItem:OnExit()
	return
end

function ActivityPushBoxRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_11_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_11_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityPushBoxRewardItem
