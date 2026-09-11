local ActivityHeroEnhancePopView_4_5 = class("ActivityHeroEnhancePopView_4_5", ReduxView)

function ActivityHeroEnhancePopView_4_5:UIName()
	return ActivityHeroEnhanceTools.GetTalentPopUIName(self.params_.activityID)
end

function ActivityHeroEnhancePopView_4_5:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityHeroEnhancePopView_4_5:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityHeroEnhancePopView_4_5:InitUI()
	self:BindCfgUI()
end

function ActivityHeroEnhancePopView_4_5:AddUIListener()
	self:AddBtnListener(nil, self.bgBtn_, function()
		JumpTools.Back(nil, {
			isPopBack = true
		})
	end)
end

function ActivityHeroEnhancePopView_4_5:OnEnter()
	self.talentId_ = self.params_.talentID

	self:RefreshUI()
end

function ActivityHeroEnhancePopView_4_5:OnExit()
	manager.windowBar:HideBar()
end

function ActivityHeroEnhancePopView_4_5:RefreshUI()
	self.talentImg_.sprite = getAffixSprite({
		TalentTreeCfg[self.talentId_].affix_id
	})
	self.nameText_.text = GetI18NText(TalentTreeCfg[self.talentId_].name)
	self.descText_.text = GetI18NText(TalentTreeCfg[self.talentId_].desc)
end

function ActivityHeroEnhancePopView_4_5:Dispose()
	ActivityHeroEnhancePopView_4_5.super.Dispose(self)
end

return ActivityHeroEnhancePopView_4_5
