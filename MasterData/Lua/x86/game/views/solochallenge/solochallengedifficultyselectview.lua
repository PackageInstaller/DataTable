local SoloChallengeDifficultySelectView = class("SoloChallengeDifficultySelectView", ReduxView)

function SoloChallengeDifficultySelectView:UIName()
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeChoosedifficult"
end

function SoloChallengeDifficultySelectView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloChallengeDifficultySelectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectItemHandler_ = handler(self, self.OnSelectItem)
	self.difficultyItemList_ = {}

	for iter_3_0 = 1, self.panelTrans_.childCount do
		self.difficultyItemList_[iter_3_0] = SoloChallengeDifficultyItem.New(self.panelTrans_:GetChild(iter_3_0 - 1))

		self.difficultyItemList_[iter_3_0]:SetSelectCallBack(self.selectItemHandler_)
	end
end

function SoloChallengeDifficultySelectView:AddListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.difficultyIndex_ == nil then
			ShowTips("SELECT_CURRENT")

			return
		end

		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.SaveDifficulty(self.activityID_, self.difficultyIndex_, handler(self, self.OnStart))
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function SoloChallengeDifficultySelectView:OnStart()
	SoloChallengeData:SetSelectedDifficultyIndex(self.activityID_, self.difficultyIndex_)
	self:Go("/factorySoloChallengeSelect", {
		activityID = self.activityID_,
		difficultyIndex = self.difficultyIndex_
	})
end

function SoloChallengeDifficultySelectView:OnEnter()
	manager.windowBar:HideBar()

	self.activityID_ = self.params_.activityID
	self.difficultyIndex_ = SoloChallengeData:GetSelectedDifficultyIndex(self.activityID_) or 1

	SoloChallengeData:SetSelectedDifficultyIndex(self.activityID_, self.difficultyIndex_)
	self:RefreshUI()
end

function SoloChallengeDifficultySelectView:OnExit()
	self.difficultyIndex_ = nil
end

function SoloChallengeDifficultySelectView:Dispose()
	self.selectItemHandler_ = nil

	for iter_10_0, iter_10_1 in ipairs(self.difficultyItemList_) do
		iter_10_1:Dispose()
	end

	self.difficultyItemList_ = nil

	SoloChallengeDifficultySelectView.super.Dispose(self)
end

function SoloChallengeDifficultySelectView:OnSelectItem(arg_11_1)
	self.difficultyIndex_ = arg_11_1

	SoloChallengeData:SetSelectedDifficultyIndex(self.activityID_, self.difficultyIndex_)

	for iter_11_0, iter_11_1 in ipairs(self.difficultyItemList_) do
		iter_11_1:SetSelect(arg_11_1)
	end
end

function SoloChallengeDifficultySelectView:RefreshUI()
	for iter_12_0, iter_12_1 in ipairs(self.difficultyItemList_) do
		iter_12_1:SetData(self.activityID_, iter_12_0)
		iter_12_1:SetSelect(self.difficultyIndex_)
	end
end

return SoloChallengeDifficultySelectView
