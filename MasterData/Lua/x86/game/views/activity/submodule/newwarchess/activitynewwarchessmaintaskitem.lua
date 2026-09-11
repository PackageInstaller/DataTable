local ActivityNewWarChessMainTaskItem = class("ActivityNewWarChessMainTaskItem", ReduxView)

function ActivityNewWarChessMainTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityNewWarChessMainTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityNewWarChessMainTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityNewWarChessMainTaskItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
end

function ActivityNewWarChessMainTaskItem:GetTaskComplete()
	local var_7_0 = TaskData2:GetTask(self.taskID_)

	return var_7_0 == nil or var_7_0.complete_flag >= 1
end

function ActivityNewWarChessMainTaskItem:Refresh(arg_8_1, arg_8_2)
	self.taskID_ = arg_8_1
	self.activityID_ = arg_8_2
	self.cfg_ = AssignmentCfg[arg_8_1]
	self.info_ = TaskData2:GetTask(self.taskID_)

	self:RefreshUI()
end

function ActivityNewWarChessMainTaskItem:RefreshUI()
	self:RefreshReward()
	self:RefreshTask()
end

function ActivityNewWarChessMainTaskItem:RefreshReward()
	for iter_10_0, iter_10_1 in ipairs(self.cfg_.reward) do
		if not self.rewardItems_[iter_10_0] then
			self.rewardItems_[iter_10_0] = RewardItem.New(self.rewardItem_, self.rewardParent_)

			self.rewardItems_[iter_10_0]:UpdateCommonItemAni()
		end

		self.rewardItems_[iter_10_0]:SetData(iter_10_1)
	end

	for iter_10_2 = #self.cfg_.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:Show(false)
	end
end

function ActivityNewWarChessMainTaskItem:RefreshTask()
	self.desc_.text = self.cfg_.desc

	local var_11_0

	if self.info_.progress > self.cfg_.need then
		var_11_0 = self.cfg_.need or self.info_.progress

		if self.info_.complete_flag >= 1 then
			var_11_0 = self.cfg_.need
		end
	end

	self.progress_.text = var_11_0 .. "/" .. self.cfg_.need
	self.slider_.value = var_11_0 / self.cfg_.need

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
		self.stateCon_:SetSelectedState("go")
	end
end

function ActivityNewWarChessMainTaskItem:OnExit()
	return
end

function ActivityNewWarChessMainTaskItem:Dispose()
	self:RemoveAllListeners()

	for iter_13_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_13_0]:Dispose()
	end

	self.rewardItems_ = {}

	self.super.Dispose(self)
end

return ActivityNewWarChessMainTaskItem
