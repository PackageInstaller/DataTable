local SpringFestivalRiddleRewardView = class("SpringFestivalRiddleRewardView", ReduxView)

function SpringFestivalRiddleRewardView:UIName()
	return "UI/EmptyDream/Riddle/RiddleRewardUI"
end

function SpringFestivalRiddleRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalRiddleRewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rewardUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, SpringFestivalRiddleRewardItem)
end

function SpringFestivalRiddleRewardView:OnEnter()
	local var_4_0 = SpringFestivalRiddleData:GetReceiveList(self.params_.activityID)
	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.params_.activityID]) do
		if table.keyof(var_4_0, iter_4_1) then
			table.insert(var_4_2, iter_4_1)
		else
			table.insert(var_4_1, iter_4_1)
		end
	end

	table.insertto(var_4_1, var_4_2)

	self.sortList_ = var_4_1

	self.rewardUIList_:StartScroll(#ActivityPointRewardCfg.get_id_list_by_activity_id[self.params_.activityID], 1)
end

function SpringFestivalRiddleRewardView:OnExit()
	return
end

function SpringFestivalRiddleRewardView:Dispose()
	if self.rewardUIList_ then
		self.rewardUIList_:Dispose()

		self.rewardUIList_ = nil
	end

	SpringFestivalRiddleRewardView.super.Dispose(self)
end

function SpringFestivalRiddleRewardView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function SpringFestivalRiddleRewardView:RefreshItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.params_.activityID, self.sortList_[arg_9_1])
end

return SpringFestivalRiddleRewardView
