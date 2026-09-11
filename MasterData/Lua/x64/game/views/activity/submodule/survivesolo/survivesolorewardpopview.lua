local SurviveSoloRewardPopView = class("SurviveSoloRewardPopView", ReduxView)

function SurviveSoloRewardPopView:UIName()
	return SurviveSoloTools.GetRewardPopView(self.params_.activityID)
end

function SurviveSoloRewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SurviveSoloRewardPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SurviveSoloRewardPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SurviveSoloRewardItem)
end

function SurviveSoloRewardPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1], self.activityID_)
end

function SurviveSoloRewardPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function SurviveSoloRewardPopView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.list_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[self.activityID_]

	self:RefreshReward()
	self:RefreshList()
end

function SurviveSoloRewardPopView:RefreshReward()
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

function SurviveSoloRewardPopView:RefreshList()
	for iter_10_0, iter_10_1 in ipairs(self.list_) do
		local var_10_1 = SurviveSoloData:GetData(iter_10_1)

		if var_10_1 then
			for iter_10_2, iter_10_3 in ipairs(ActivitySoloSlayerCfg[iter_10_1].reward_item_list) do
				if var_10_1.time >= iter_10_3[1] and not table.indexof(var_10_1.rewards, iter_10_3[1]) then
					self.scrollHelper_:StartScroll(#self.list_, iter_10_0)

					return
				end
			end
		end
	end

	self.scrollHelper_:StartScroll(#self.list_)
end

function SurviveSoloRewardPopView:OnSurviveSoloReward()
	self:RefreshReward()
	self.scrollHelper_:Refresh()
end

function SurviveSoloRewardPopView:OnExit()
	return
end

function SurviveSoloRewardPopView:Dispose()
	self:RemoveAllListeners()

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return SurviveSoloRewardPopView
