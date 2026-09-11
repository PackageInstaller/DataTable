local ActivityPt2TaskItem = class("ActivityPt2TaskItem", ReduxView)

function ActivityPt2TaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPt2TaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPt2TaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityPt2TaskItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityPt2TaskItem:Refresh(arg_6_1, arg_6_2)
	self.taskID_ = arg_6_1
	self.activityID_ = arg_6_2
	self.taskActivityID_ = ActivityPt2Tools:GetTaskActivityID(self.activityID_)
	self.info_ = TaskData2:GetTask(self.taskID_)
	self.cfg_ = AssignmentCfg[arg_6_1]

	self:RefreshUI()
end

function ActivityPt2TaskItem:RefreshUI()
	self:RefreshReward()
	self:RefreshTask()
end

function ActivityPt2TaskItem:RefreshReward()
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

function ActivityPt2TaskItem:RefreshTask()
	self.desc_.text = GetI18NText(self.cfg_.desc)

	local var_9_0

	if self.info_.progress > self.cfg_.need then
		var_9_0 = self.cfg_.need or self.info_.progress
	end

	self.progress_.text = var_9_0 .. "/" .. self.cfg_.need
	self.slider_.value = var_9_0 / self.cfg_.need

	if self.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeCon_:SetSelectedState("normal")
	else
		self.typeCon_:SetSelectedState("challenge")
	end

	if self.info_.complete_flag >= 1 then
		self.stateCon_:SetSelectedState("received")
	elseif self.info_.progress >= self.cfg_.need then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function ActivityPt2TaskItem:OnExit()
	return
end

function ActivityPt2TaskItem:Dispose()
	self:RemoveAllListeners()

	for iter_11_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_11_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityPt2TaskItem
