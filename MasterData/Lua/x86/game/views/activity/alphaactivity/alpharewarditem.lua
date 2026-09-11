local AlphaRewardItem = class("AlphaRewardItem", ReduxView)

function AlphaRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function AlphaRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
end

function AlphaRewardItem:AddListeners()
	return
end

function AlphaRewardItem:OnEnter()
	return
end

function AlphaRewardItem:GetTaskID()
	return self.taskID_
end

function AlphaRewardItem:RefreshReward(arg_6_1)
	self.taskID_ = arg_6_1
	self.titleText_.text = GetI18NText(AssignmentCfg[arg_6_1].desc)

	for iter_6_0, iter_6_1 in ipairs(AssignmentCfg[arg_6_1].reward) do
		if self.rewardItems_[iter_6_0] == nil then
			self.rewardItems_[iter_6_0] = RewardItem.New(self.rewardTemplate_, self.rewardParent_, true)

			self.rewardItems_[iter_6_0]:UpdateCommonItemAni()
		end

		self.rewardItems_[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #AssignmentCfg[arg_6_1].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_6_2]:Show(false)
	end
end

function AlphaRewardItem:OnExit()
	return
end

function AlphaRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_8_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_0]:Dispose()

		self.rewardItems_[iter_8_0] = nil
	end

	self.rewardItems_ = nil

	AlphaRewardItem.super.Dispose(self)
end

return AlphaRewardItem
