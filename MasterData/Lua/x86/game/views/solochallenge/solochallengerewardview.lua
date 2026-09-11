local SoloChallengeRewardView = class("SoloChallengeRewardView", ReduxView)

function SoloChallengeRewardView:UIName()
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeRewardUI"
end

function SoloChallengeRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function SoloChallengeRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SoloChallengeRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, self:GetRewardItemClass())
end

function SoloChallengeRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function SoloChallengeRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function SoloChallengeRewardView:RefreshUI()
	self:RefreshLevelName()
	self:RefreshScroll()
end

function SoloChallengeRewardView:RefreshLevelName()
	self.levelNameText_.text = GetI18NText(ActivitySoloChallengeCfg[self.activityID_].name)
end

function SoloChallengeRewardView:RefreshScroll()
	self.scrollHelper_:StartScroll(self:GetAwardListLength())
end

function SoloChallengeRewardView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshData({
		activityID = self.activityID_,
		difficultyIndex = arg_11_1
	})
end

function SoloChallengeRewardView:OnExit()
	return
end

function SoloChallengeRewardView:GetAwardListLength()
	return #ActivitySoloChallengeCfg[self.activityID_].reward_item_list
end

function SoloChallengeRewardView:Dispose()
	SoloChallengeRewardView.super.Dispose(self)
	self.scrollHelper_:Dispose()
end

function SoloChallengeRewardView:GetRewardItemClass()
	return SoloChallengeRewardItem
end

return SoloChallengeRewardView
