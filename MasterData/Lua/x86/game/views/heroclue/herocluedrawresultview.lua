local HeroClueDrawResultView = class("HeroClueDrawResultView", ReduxView)

function HeroClueDrawResultView:UIName()
	return HeroClueTools.GetDrawResultViewUIName(self.params_.activityID)
end

function HeroClueDrawResultView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroClueDrawResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroClueDrawResultView:InitUI()
	self:BindCfgUI()
end

function HeroClueDrawResultView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function HeroClueDrawResultView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.rewardList_ = self.params_.rewardList
	self.clueID_ = self.rewardList_[1]

	self:RefreshUI()
end

function HeroClueDrawResultView:RefreshUI()
	self.clueIcon_.sprite = pureGetSpriteWithoutAtlas(HeroClueCfg[self.clueID_].icon_path)
	self.clueName_.text = string.format(GetTips("ACTIVITY_HERO_CLUE_UNLOCK"), HeroClueCfg[self.clueID_].name)
	self.progressText_.text = string.format(GetTips("ACTIVITY_HERO_CLUE_COLLECT"), HeroClueData:GetUnlockClueDataDic()[self.clueID_].level, #HeroClueCfg[self.clueID_].level)
end

return HeroClueDrawResultView
