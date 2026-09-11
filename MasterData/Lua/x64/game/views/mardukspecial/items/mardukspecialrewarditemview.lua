local MardukSpecialRewardItemView = class("MardukSpecialRewardItemView", ReduxView)

function MardukSpecialRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MardukSpecialRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialRewardItemView:InitUI()
	self:BindCfgUI()

	self.items_ = {
		MardukSpecialRewardConditionItemView.New(self.itemGo1_),
		MardukSpecialRewardConditionItemView.New(self.itemGo2_),
		MardukSpecialRewardConditionItemView.New(self.itemGo3_)
	}
end

function MardukSpecialRewardItemView:AddUIListener()
	return
end

function MardukSpecialRewardItemView:AddEventListeners()
	return
end

function MardukSpecialRewardItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.activityId_ = arg_6_2
	self.quickTrainingCfg_ = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[self.activityId_].stage_id]
	self.rewardIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_2]

	self:UpdateView()
end

function MardukSpecialRewardItemView:UpdateView()
	self.nameLabel.text = GetI18NText(self.quickTrainingCfg_.name)
	self.scoreLabel1_.text = MardukSpecialData:GetPoint(self.activityId_)
	self.scoreLabel2_.text = "/" .. ActivityPointRewardCfg[self.rewardIdList_[#self.rewardIdList_]].need

	for iter_7_0, iter_7_1 in ipairs(self.items_) do
		iter_7_1:SetData(iter_7_0, self.rewardIdList_[iter_7_0], self.activityId_)
	end
end

function MardukSpecialRewardItemView:OnEnter()
	self:AddEventListeners()

	for iter_8_0, iter_8_1 in ipairs(self.items_) do
		iter_8_1:OnEnter()
	end
end

function MardukSpecialRewardItemView:OnExit()
	self:RemoveAllEventListener()

	for iter_9_0, iter_9_1 in ipairs(self.items_) do
		iter_9_1:OnExit()
	end
end

function MardukSpecialRewardItemView:OnMainHomeViewTop()
	return
end

function MardukSpecialRewardItemView:Dispose()
	self.data_ = nil

	if self.items_ then
		for iter_11_0, iter_11_1 in pairs(self.items_) do
			iter_11_1:Dispose()
		end

		self.items_ = nil
	end

	MardukSpecialRewardItemView.super.Dispose(self)
end

return MardukSpecialRewardItemView
