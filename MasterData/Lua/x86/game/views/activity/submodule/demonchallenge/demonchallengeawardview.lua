local DemonChallengeAwardView = class("DemonChallengeAwardView", ReduxView)

function DemonChallengeAwardView:UIName()
	return DemonChallengeTools.GetAwardUIName(self.params_.selectId)
end

function DemonChallengeAwardView:UIParent()
	return manager.ui.uiPop.transform
end

function DemonChallengeAwardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DemonChallengeAwardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, DemonChallengeAwardItem)
end

function DemonChallengeAwardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function DemonChallengeAwardView:OnEnter()
	self.activityId_ = self.params_.selectId

	self:RefreshUI()
end

function DemonChallengeAwardView:RefreshUI()
	self:RefreshLevelName()
	self:RefreshScroll()
end

function DemonChallengeAwardView:RefreshLevelName()
	local var_9_0 = BattleHeartDemonStageCfg[DemonChallengeTools.GetStageId(self.activityId_, 1)]

	if var_9_0 then
		self.levelNameText_.text = GetI18NText(var_9_0.name)
	end
end

function DemonChallengeAwardView:RefreshScroll()
	self.sortedRewardList_ = self:GetAwardData()

	self.scrollHelper_:StartScroll(#self.sortedRewardList_)
end

function DemonChallengeAwardView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshData({
		activityId = self.activityId_,
		id = self.sortedRewardList_[arg_11_1]
	})
end

function DemonChallengeAwardView:OnDemonChallengeReceiveReward(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs((self.scrollHelper_:GetItemList())) do
		local var_12_0 = iter_12_1:GetItemInfo()

		if var_12_0.id == arg_12_2.id then
			iter_12_1:RefreshData(var_12_0)
		end
	end
end

function DemonChallengeAwardView:OnExit()
	return
end

function DemonChallengeAwardView:GetAwardData()
	return deepClone(DemonChallengeCfg.get_id_list_by_activity_id[self.activityId_])
end

function DemonChallengeAwardView:Dispose()
	DemonChallengeAwardView.super.Dispose(self)
	self.scrollHelper_:Dispose()
end

return DemonChallengeAwardView
