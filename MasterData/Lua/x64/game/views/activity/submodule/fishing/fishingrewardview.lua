local FishingRewardView = class("FishingRewardView", ReduxView)

function FishingRewardView:UIName()
	return "UI/Fishing/FishingRewardUI"
end

function FishingRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingRewardView:OnCtor()
	return
end

function FishingRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, FishingRewardItemView)
end

function FishingRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetId(self.rewardIdList_[arg_6_1])
end

function FishingRewardView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function FishingRewardView:AddEventListeners()
	self:RegistEventListener(FISHING_SCORE_REWARD_CHANGE, function()
		self:SortData()
		self:UpdateView()
	end)
	self:RegistEventListener(RARE_FISH_CHANGE, function(arg_12_0)
		self:UpdateView()
	end)
end

function FishingRewardView:OnTop()
	self:UpdateBar()
end

function FishingRewardView:UpdateBar()
	return
end

function FishingRewardView:OnEnter()
	self:AddEventListeners()

	self.rewardIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]

	self:SortData()
	self:UpdateView()
end

function FishingRewardView:SortData()
	local var_16_0 = 0
	local var_16_1 = FishingData:GetActivityData()

	if var_16_1 then
		var_16_0 = var_16_1.score
	end

	local var_16_2 = FishingData:GetActivityData().received_award_list

	table.sort(self.rewardIdList_, function(arg_17_0, arg_17_1)
		local var_17_0 = ActivityPointRewardCfg[arg_17_0]
		local var_17_1 = ActivityPointRewardCfg[arg_17_1]
		local var_17_2 = table.indexof(var_16_2, ActivityPointRewardCfg[arg_17_0].id) or 0
		local var_17_3 = table.indexof(var_16_2, ActivityPointRewardCfg[arg_17_1].id) or 0

		if (var_17_2 == 0 or var_17_3 == 0) and var_17_2 ~= var_17_3 then
			return var_17_2 < var_17_3
		end

		if (var_16_0 >= var_17_0.need and 1 or 0) ~= (var_16_0 >= var_17_1.need and 1 or 0) then
			return (var_16_0 >= var_17_1.need and 1 or 0) < (var_16_0 >= var_17_0.need and 1 or 0)
		end

		return arg_17_0 < arg_17_1
	end)
end

function FishingRewardView:UpdateView()
	self.uiList_:StartScroll(#self.rewardIdList_)

	local var_18_1 = FishingData:GetActivityData()

	if var_18_1 then
		self.currentLabel_.text = var_18_1.score
	end
end

function FishingRewardView:OnExit()
	self:RemoveAllEventListener()
end

function FishingRewardView:OnMainHomeViewTop()
	return
end

function FishingRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingRewardView.super.Dispose(self)
end

return FishingRewardView
