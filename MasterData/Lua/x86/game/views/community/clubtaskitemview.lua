local ClubTaskItemView = class("ClubTaskItemView", ReduxView)

function ClubTaskItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ClubTaskItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ClubTaskItemView:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ClubTaskItemView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(self.taskCfg_.source)
	end)
end

function ClubTaskItemView:OnEnter()
	return
end

function ClubTaskItemView:RefreshUI(arg_8_1)
	self.taskID_ = arg_8_1
	self.info_ = TaskData2:GetTask(self.taskID_)
	self.taskCfg_ = AssignmentCfg[self.taskID_]
	self.titleText_.text = GetI18NText(self.taskCfg_.desc)

	self:RefreshType()
	self:RefreshProgress()
	self:RefreshReward()
end

function ClubTaskItemView:RefreshType()
	return
end

function ClubTaskItemView:RefreshReward()
	return
end

function ClubTaskItemView:RefreshProgress()
	return
end

function ClubTaskItemView:OnExit()
	for iter_12_0 = #self.rewardItems_, 1, -1 do
		self.rewardItems_[iter_12_0]:OnExit()
	end
end

function ClubTaskItemView:Dispose()
	self:RemoveAllListeners()

	for iter_13_0 = #self.rewardItems_, 1, -1 do
		self.rewardItems_[iter_13_0]:Dispose()

		self.rewardItems_[iter_13_0] = nil
	end

	ClubTaskItemView.super.Dispose(self)
end

return ClubTaskItemView
