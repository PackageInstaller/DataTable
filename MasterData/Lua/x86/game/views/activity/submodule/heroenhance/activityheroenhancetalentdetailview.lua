local ActivityHeroEnhanceTalentDetailView = class("ActivityHeroEnhanceTalentDetailView", ReduxView)

function ActivityHeroEnhanceTalentDetailView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function ActivityHeroEnhanceTalentDetailView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.talentItem_ = ActivityHeroEnhanceTalentItem.New(self.talentGo_)
	self.useController_ = self.controller_:GetController("use")
end

function ActivityHeroEnhanceTalentDetailView:AddUIListener()
	self:AddBtnListener(self.useBtn_, nil, function()
		if self.onClickBtnHandler_ then
			self.onClickBtnHandler_(true, self.talentId_)
		end
	end)
	self:AddBtnListener(self.dropBtn_, nil, function()
		if self.onClickBtnHandler_ then
			self.onClickBtnHandler_(false, self.talentId_)
		end
	end)
end

function ActivityHeroEnhanceTalentDetailView:OnEnter()
	return
end

function ActivityHeroEnhanceTalentDetailView:OnExit()
	return
end

function ActivityHeroEnhanceTalentDetailView:PlayAnim()
	self.animator_:Play("Fx_TalentDetailUI_cx", 0, 0)
end

function ActivityHeroEnhanceTalentDetailView:SetData(arg_9_1, arg_9_2)
	self.activityId_ = arg_9_1
	self.talentId_ = arg_9_2

	self:PlayAnim()
end

function ActivityHeroEnhanceTalentDetailView:SetClickBtnHandler(arg_10_1)
	self.onClickBtnHandler_ = arg_10_1
end

function ActivityHeroEnhanceTalentDetailView:RefreshUI()
	local var_11_0 = self.talentId_

	self.talentItem_:SetData(self.activityId_, self.talentId_)
	self.talentItem_:RefreshUI()

	self.descText_.text = GetI18NText(TalentTreeCfg[var_11_0].desc)

	local var_11_1 = ActivityHeroEnhanceTools.GetTalentLockConditionId(self.activityId_, var_11_0)

	if var_11_1 then
		self.useController_:SetSelectedState("lock")

		self.lockText_.text = ConditionCfg[var_11_1].desc
	elseif ActivityTools.GetActivityTheme(self.activityId_) == ActivityConst.THEME.ACTIVITY_4_5 then
		self.useController_:SetSelectedState("none")
	else
		self.useController_:SetSelectedState(ActivityHeroEnhanceData:IsTalentActivated(self.activityId_, var_11_0) and "used" or "use")
	end
end

function ActivityHeroEnhanceTalentDetailView:Dispose()
	self.talentItem_:Dispose()
	ActivityHeroEnhanceTalentDetailView.super.Dispose(self)
end

return ActivityHeroEnhanceTalentDetailView
