local DemonChallengerewardView = class("DemonChallengerewardView", ReduxView)

function DemonChallengerewardView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisChallengerewardUI"
end

function DemonChallengerewardView:UIParent()
	return manager.ui.uiMain.transform
end

function DemonChallengerewardView:Init()
	self.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()

	self:InitUI()
	self:AddUIListener()
end

function DemonChallengerewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, TaskDemonChallengeItemView)
	self.refreshHandler_ = handler(self, self.RefreshScroll)
end

function DemonChallengerewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function DemonChallengerewardView:OnEnter()
	self.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()

	self:RefreshUI()
	manager.notify:RegistListener(DEMON_CHALLENGE_RECEIVE_REWARD, self.refreshHandler_)
end

function DemonChallengerewardView:RefreshUI()
	self:RefreshLevelName()
	self:RefreshScroll()
end

function DemonChallengerewardView:RefreshLevelName()
	self.levelNameText_.text = DemonChallengeData:GetLevelName(self.levelIndex_)
end

function DemonChallengerewardView:RefreshScroll()
	self:UpdateData()
	self.scrollHelper_:StartScroll(#self.sortedRewardList_)
end

function DemonChallengerewardView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(DemonChallengeData:GetDropId(self.levelIndex_, self.sortedRewardList_[arg_11_1]), self.sortedRewardList_[arg_11_1], self.levelIndex_)
end

function DemonChallengerewardView:OnExit()
	manager.notify:RemoveListener(DEMON_CHALLENGE_RECEIVE_REWARD, self.refreshHandler_)
end

function DemonChallengerewardView:UpdateData()
	self.sortedRewardList_ = DemonChallengeData:GetSortedRewardIndexList(self.levelIndex_)
end

function DemonChallengerewardView:Dispose()
	self.scrollHelper_:Dispose()
	DemonChallengerewardView.super.Dispose(self)
end

return DemonChallengerewardView
