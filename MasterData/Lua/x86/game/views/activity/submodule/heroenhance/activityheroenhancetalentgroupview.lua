local ActivityHeroEnhanceTalentDetailView = class("ActivityHeroEnhanceTalentDetailView", ReduxView)

function ActivityHeroEnhanceTalentDetailView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.expanded_ = false
	self.selected_ = false

	self:InitUI()
end

function ActivityHeroEnhanceTalentDetailView:InitUI()
	self:BindCfgUI()

	self.talentItem_ = ActivityHeroEnhanceTalentItem.New(self.curTalentGo_)
	self.lineController_ = self.controller_:GetController("line")

	self:AddUIListener()
end

function ActivityHeroEnhanceTalentDetailView:AddUIListener()
	self.talentItem_:SetClickHandler(function(arg_4_0)
		self:OnClickTalent(true, arg_4_0, 0)
	end)
end

function ActivityHeroEnhanceTalentDetailView:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.cfgId_ = arg_5_1
	self.stage_ = arg_5_2
	self.talentIdList_ = arg_5_3
end

function ActivityHeroEnhanceTalentDetailView:SetSelected(arg_6_1)
	self.selected_ = arg_6_1
end

function ActivityHeroEnhanceTalentDetailView:SelectIdx(arg_7_1)
	self.selectIdx_ = arg_7_1

	self:RefreshUI_SelectState()
end

function ActivityHeroEnhanceTalentDetailView:SetClickHandler(arg_8_1)
	self.onClickTalenCallback_ = arg_8_1
end

function ActivityHeroEnhanceTalentDetailView:RefreshUI()
	local var_9_0 = ActivityHeroEnhanceTools.IsTalentLock(ActivityHeroEnhanceCfg[self.cfgId_].activity_id, self.talentIdList_[1])

	self.talentItem_:SetData(ActivityHeroEnhanceCfg[self.cfgId_].activity_id, self.talentIdList_[1])
	self.talentItem_:SetSelected(self.selected_)
	self.talentItem_:SetLock(var_9_0)
	self.talentItem_:SetFirstAddFlag(ActivityHeroEnhanceTools.IsCfgTalentStageFirstCanAdd(ActivityHeroEnhanceCfg[self.cfgId_], self.stage_))
	self.talentItem_:RefreshUI()
	self.lineController_:SetSelectedState(var_9_0 and "weak" or "normal")
end

function ActivityHeroEnhanceTalentDetailView:RefreshUI_SelectState()
	self.talentItem_:SetSelected(self.selected_)
	self.talentItem_:RefreshUI()
end

function ActivityHeroEnhanceTalentDetailView:OnClickTalent(arg_11_1, arg_11_2, arg_11_3)
	if self.onClickTalenCallback_ then
		self.onClickTalenCallback_(arg_11_1, self.stage_, arg_11_2, arg_11_3)
	end
end

function ActivityHeroEnhanceTalentDetailView:Dispose()
	self.talentItem_:Dispose()
	ActivityHeroEnhanceTalentDetailView.super.Dispose(self)
end

return ActivityHeroEnhanceTalentDetailView
