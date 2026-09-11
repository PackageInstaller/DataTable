local HeroClueDetailView = class("HeroClueDetailView", ReduxView)

function HeroClueDetailView:UIName()
	return HeroClueTools.GetClueDetailViewUIName(self.params_.activityID)
end

function HeroClueDetailView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroClueDetailView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroClueDetailView:InitUI()
	self:BindCfgUI()
end

function HeroClueDetailView:AddUIListener()
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:Back()
	end)
end

function HeroClueDetailView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.clueID_ = self.params_.clueID

	self:RefreshUI()
end

function HeroClueDetailView:RefreshUI()
	local var_8_0 = HeroClueData:GetUnlockClueDataDic()[self.clueID_]

	if var_8_0 then
		if var_8_0.level == 1 then
			self.clueNameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
			self.clueDescText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		elseif var_8_0.level == 2 then
			self.clueNameText_.text = HeroClueCfg[self.clueID_].name
			self.clueDescText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		else
			self.clueNameText_.text = HeroClueCfg[self.clueID_].name
			self.clueDescText_.text = HeroClueCfg[self.clueID_].desc
		end
	end
end

return HeroClueDetailView
