local ChallengeRogueTeamTreasureUpgradeView = class("ChallengeRogueTeamTreasureUpgradeView", ReduxView)

function ChallengeRogueTeamTreasureUpgradeView:UIName()
	return "Widget/System/Activity_Roulike/RoulikeUptreasurepopUI"
end

function ChallengeRogueTeamTreasureUpgradeView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamTreasureUpgradeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.originItemView_ = ChallengeRogueTeamCommonItemView.New(self.originItemGo_)
	self.upgradeItemView_ = ChallengeRogueTeamCommonItemView.New(self.upgradeItemGo_)
end

function ChallengeRogueTeamTreasureUpgradeView:OnEnter()
	self.currentIndex_ = 1
	self.triggerValue_ = self.params_.triggerValue

	self:RefreshUI()
end

function ChallengeRogueTeamTreasureUpgradeView:OnExit()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
end

function ChallengeRogueTeamTreasureUpgradeView:Dispose()
	self.originItemView_:Dispose()

	self.originItemView_ = nil

	self.upgradeItemView_:Dispose()

	self.upgradeItemView_ = nil

	ChallengeRogueTeamTreasureUpgradeView.super.Dispose(self)
end

function ChallengeRogueTeamTreasureUpgradeView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self.currentIndex_ >= #self.triggerValue_.itemList then
			ChallengeRogueTeamData:ClearObtainData()
			ChallengeRogueTeamData:RemoveServerTriggerQueue()
			self:Back()
			ChallengeRogueTeamAction.RemovePopWindowCnt()
		else
			self.currentIndex_ = self.currentIndex_ + 1

			self:RefreshUI()
		end
	end)
end

function ChallengeRogueTeamTreasureUpgradeView:RefreshUI()
	local var_9_0 = clone(ChallengeRogueTeamCommonItemData)

	var_9_0.id = self.triggerValue_.itemList[self.currentIndex_].id
	var_9_0.rare = self.triggerValue_.itemList[self.currentIndex_].sourceRare
	var_9_0.descRaycastFlag = true

	self.originItemView_:SetData(var_9_0)

	local var_9_1 = clone(ChallengeRogueTeamCommonItemData)

	var_9_1.id = self.triggerValue_.itemList[self.currentIndex_].id
	var_9_1.rare = self.triggerValue_.itemList[self.currentIndex_].rare
	var_9_1.descRaycastFlag = true

	self.upgradeItemView_:SetData(var_9_1)

	self.titleText_.text = GetTips("ROGUE_TEAM_TREASURE_UPGRADE_TITLE")
end

return ChallengeRogueTeamTreasureUpgradeView
