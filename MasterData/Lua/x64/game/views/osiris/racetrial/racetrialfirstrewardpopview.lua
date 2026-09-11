local RaceTrialScoreRewardPopView = class("RaceTrialScoreRewardPopView", ReduxView)

function RaceTrialScoreRewardPopView:UIName()
	return RaceTrialTools.GetFirstRewardPopUIName(self.params_.mainActivityID)
end

function RaceTrialScoreRewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RaceTrialScoreRewardPopView:OnCtor()
	return
end

function RaceTrialScoreRewardPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialScoreRewardPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RaceTrialTools.GetFirstRewardPopItem(self.params_.mainActivityID))
end

function RaceTrialScoreRewardPopView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.list_[arg_6_1], self.activityID)
end

function RaceTrialScoreRewardPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.recieveAllBtn_, nil, function()
		RaceTrialAction:ReceiveMultipleFirstClearLevelReward(self.activityID, self:CollectRecievableFirstClearLevelReward())
	end)
end

function RaceTrialScoreRewardPopView:OnEnter()
	self:RefreshUI()
end

function RaceTrialScoreRewardPopView:RefreshUI()
	self.activityID = self.params_.mainActivityID
	self.list_, self.completeBattleList = RaceTrialData:GetFirstRewardSortList(self.params_.mainActivityID)
	self.subActivityList_ = ActivityData:GetActivityData(self.params_.mainActivityID).subActivityIdList

	self.scrollHelper_:StartScroll(#self.list_)

	if #self:CollectRecievableFirstClearLevelReward() > 0 then
		SetActive(self.recieveAllTips_, true)
	else
		SetActive(self.recieveAllTips_, false)
	end
end

function RaceTrialScoreRewardPopView:OnFirstReceive()
	self:RefreshUI()
end

function RaceTrialScoreRewardPopView:OnExit()
	return
end

function RaceTrialScoreRewardPopView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	RaceTrialScoreRewardPopView.super.Dispose(self)
end

function RaceTrialScoreRewardPopView:CollectRecievableFirstClearLevelReward()
	return self.completeBattleList or {}
end

return RaceTrialScoreRewardPopView
