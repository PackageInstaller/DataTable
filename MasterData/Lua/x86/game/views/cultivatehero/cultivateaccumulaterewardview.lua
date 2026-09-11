local CultivateAccumulateRewardView = class("CultivateAccumulateRewardView", ReduxView)

function CultivateAccumulateRewardView:UIName()
	return CultivateHeroTools.GetRewardUIName(self.params_.activityID)
end

function CultivateAccumulateRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function CultivateAccumulateRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CultivateAccumulateRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CultivateAccumulateRewardItem)
end

function CultivateAccumulateRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function CultivateAccumulateRewardView:OnEnter()
	self.activityID_ = self.params_.rewardActivityID

	self:RefreshUI()
end

function CultivateAccumulateRewardView:RefreshUI()
	self.scoreText_.text = ItemTools.getItemNum(ActivityCultivateHeroCfg[self.activityID_].coin_id)
	self.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[self.activityID_].coin_id)

	self:RefreshScroll()
end

function CultivateAccumulateRewardView:RefreshScroll()
	self.scrollHelper_:StartScroll(self:GetAwardListLength())
end

function CultivateAccumulateRewardView:GetAwardListLength()
	self.taskIDList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]
	self.maxRewardNum_ = 0

	for iter_10_0, iter_10_1 in ipairs(self.taskIDList_) do
		self.maxRewardNum_ = #ActivityPointRewardCfg[iter_10_1].reward_item_list > self.maxRewardNum_ and #ActivityPointRewardCfg[iter_10_1].reward_item_list or self.maxRewardNum_
	end

	return #self.taskIDList_
end

function CultivateAccumulateRewardView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.taskIDList_[arg_11_1], self.activityID_, self.maxRewardNum_)
end

function CultivateAccumulateRewardView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	CultivateAccumulateRewardView.super.Dispose(self)
end

return CultivateAccumulateRewardView
