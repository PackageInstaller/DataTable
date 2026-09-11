local SkuldTravelRewardView = class("SkuldTravelRewardView", ReduxView)

function SkuldTravelRewardView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelreward"
end

function SkuldTravelRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelRewardView:InitUI()
	self:BindCfgUI()

	self.rewardlist_ = deepClone(TravelSkuldRewardCfg.all)

	self:RewardSort()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listgo_, SkuldTravelRewardItem)
end

function SkuldTravelRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rewardlist_[arg_5_1])
end

function SkuldTravelRewardView:AddUIListeners()
	self:AddBtnListener(self.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function SkuldTravelRewardView:OnEnter()
	self:RewardSort()
	self.list_:StartScroll(#TravelSkuldRewardCfg.all)
end

function SkuldTravelRewardView:OnExit()
	return
end

function SkuldTravelRewardView:RewardSort()
	local var_10_0 = {
		{},
		{},
		{}
	}

	for iter_10_0, iter_10_1 in pairs(self.rewardlist_) do
		table.insert(var_10_0[SkuldTravelData:GetTaskStatuByTaskId(iter_10_1)], iter_10_1)
	end

	self.rewardlist_ = {}

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		table.sort(iter_10_3)
		table.insertto(self.rewardlist_, iter_10_3)
	end
end

function SkuldTravelRewardView:OnSkuldGetReward()
	self:RewardSort()
	self.list_:Refresh()
end

function SkuldTravelRewardView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.super.Dispose(self)
end

return SkuldTravelRewardView
