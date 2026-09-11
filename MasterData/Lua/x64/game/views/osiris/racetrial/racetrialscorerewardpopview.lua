local RaceTrialScoreRewardPopView = class("RaceTrialScoreRewardPopView", ReduxView)

function RaceTrialScoreRewardPopView:UIName()
	return RaceTrialTools.GetScoreRewardUIName(self.params_.mainActivityID)
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

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RaceTrialTools.GetScoreRewardPopItem(self.params_.mainActivityID))
end

function RaceTrialScoreRewardPopView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.list_[arg_6_1], self.scoreNum_, self.params_.mainActivityID)
end

function RaceTrialScoreRewardPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.recieveAllBtn_, nil, function()
		RaceTrialAction:ReceiveAllScoreReward(self.params_.mainActivityID)
	end)
end

function RaceTrialScoreRewardPopView:OnEnter()
	self:RefreshUI()
end

function RaceTrialScoreRewardPopView:RefreshUI()
	self.list_ = RaceTrialData:GetScoreRewardSortList(self.params_.mainActivityID)
	self.scoreNum_ = RaceTrialData:GetTotalScore(self.params_.mainActivityID)
	self.score_.text = GetTipsF(RaceTrialTools.GetDisplayScorePatternTips(self.params_.mainActivityID), self.scoreNum_)

	self.scrollHelper_:StartScroll(#self.list_)

	if #self:CollectRecievableScoreReward() > 0 then
		SetActive(self.recieveAllTips_, true)
	else
		SetActive(self.recieveAllTips_, false)
	end
end

function RaceTrialScoreRewardPopView:OnPointReceive()
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

function RaceTrialScoreRewardPopView:CollectRecievableScoreReward()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self.list_) do
		if not RaceTrialData:GetScoreRewardByID(iter_15_1).receive_flag and ActivityPointRewardCfg[iter_15_1].need <= self.scoreNum_ then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

return RaceTrialScoreRewardPopView
