local ActivityHeroEnhanceHeroItem = class("ActivityHeroEnhanceHeroItem", ReduxView)

function ActivityHeroEnhanceHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function ActivityHeroEnhanceHeroItem:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller_:GetController("selected")
	self.lockController_ = self.controller_:GetController("lock")
	self.passController_ = self.controller_:GetController("pass")
end

function ActivityHeroEnhanceHeroItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.heroID)
		end
	end)
end

function ActivityHeroEnhanceHeroItem:SetClickHandler(arg_5_1)
	if arg_5_1 then
		self.onClickHandler_ = arg_5_1
	end
end

function ActivityHeroEnhanceHeroItem:SetData(arg_6_1)
	self.cfgId_ = arg_6_1
end

function ActivityHeroEnhanceHeroItem:SetIgnorePass(arg_7_1)
	self.isIgnorePass_ = arg_7_1
end

function ActivityHeroEnhanceHeroItem:SetSelected(arg_8_1)
	self.selected_ = arg_8_1

	return self.selected_
end

function ActivityHeroEnhanceHeroItem:RefreshUI()
	local var_9_0 = ActivityHeroEnhanceCfg[self.cfgId_]
	local var_9_1 = ActivityHeroEnhanceCfg[self.cfgId_].activity_id
	local var_9_2 = HeroData:GetHeroData(ActivityHeroEnhanceCfg[self.cfgId_].hero_id)

	self.headIcon_.sprite = HeroTools.GetHeadSprite(ActivityHeroEnhanceCfg[self.cfgId_].hero_id)
	self.nameText_.text = HeroTools.GetHeroFullName(ActivityHeroEnhanceCfg[self.cfgId_].hero_id)

	local var_9_4, var_9_5 = ActivityHeroEnhanceTools.IsCfgHeroLock(var_9_0)

	self.selController_:SetSelectedState(self.selected_ and "true" or "false")
	self.lockController_:SetSelectedState(var_9_4 and "true" or "false")

	if not self.isIgnorePass_ then
		self.passController_:SetSelectedState(not var_9_4 and ActivityHeroEnhanceTools.IsCfgHeroPass(var_9_0) and "true" or "false")
	end

	if var_9_4 then
		self.lockText_.text = var_9_5.isBeforeStartDay and string.format(GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION"), var_9_5.startDay - var_9_5.curDay) or GetTipsF("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION_2", (HeroTools.GetHeroFullName(ActivityHeroEnhanceTools.GetTutorialCfg(var_9_1).hero_id)))
	end
end

function ActivityHeroEnhanceHeroItem:GetRedPointTransform()
	return self.selfBtn_.transform
end

function ActivityHeroEnhanceHeroItem:GetCfgId()
	return self.cfgId_
end

function ActivityHeroEnhanceHeroItem:Dispose()
	ActivityHeroEnhanceHeroItem.super.Dispose(self)
end

return ActivityHeroEnhanceHeroItem
