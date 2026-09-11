local SurviveSolo2RewardPopView = class("SurviveSolo2RewardPopView", ReduxView)

function SurviveSolo2RewardPopView:UIName()
	return SurviveSolo2Tools.GetRewardPopView(self.params_.activityId)
end

function SurviveSolo2RewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SurviveSolo2RewardPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SurviveSolo2RewardPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SurviveSoloRewardItem)
end

function SurviveSolo2RewardPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1], self.activityID_)
end

function SurviveSolo2RewardPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function SurviveSolo2RewardPopView:OnEnter()
	self.activityID_ = self.params_.activityId
	self.list_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_]

	self:RefreshReward()
	self:RefreshList()
end

function SurviveSolo2RewardPopView:RefreshReward()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self.list_) do
		local var_9_1 = SurviveSoloData:GetData(iter_9_1)

		if var_9_1 then
			var_9_0 = var_9_0 + #var_9_1.rewards
		end
	end

	self.rewardTxt_.text = var_9_0
	self.allTxt_.text = "/" .. #self.list_ * 3
end

function SurviveSolo2RewardPopView:RefreshList()
	table.sort(self.list_, function(arg_11_0, arg_11_1)
		local var_11_0 = SurviveSoloData:GetData(arg_11_0)
		local var_11_1 = SurviveSoloData:GetData(arg_11_1)

		if var_11_0 and var_11_1 then
			local var_11_2 = self:IsComplete(arg_11_0, var_11_0)

			if var_11_2 ~= self:IsComplete(arg_11_1, var_11_1) then
				return var_11_2
			end
		end

		return arg_11_0 < arg_11_1
	end)
	self.scrollHelper_:StartScroll(#self.list_)
end

function SurviveSolo2RewardPopView:IsComplete(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(ActivitySoloSlayerCfg[arg_12_1].reward_item_list) do
		if arg_12_2.time >= iter_12_1[1] and not table.indexof(arg_12_2.rewards, iter_12_1[1]) then
			return true
		end
	end

	return false
end

function SurviveSolo2RewardPopView:OnSurviveSoloReward()
	self:RefreshReward()
	self.scrollHelper_:Refresh()
end

function SurviveSolo2RewardPopView:OnExit()
	return
end

function SurviveSolo2RewardPopView:Dispose()
	self:RemoveAllListeners()

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return SurviveSolo2RewardPopView
