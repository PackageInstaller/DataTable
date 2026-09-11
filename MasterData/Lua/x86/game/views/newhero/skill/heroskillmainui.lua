local HeroSkillView = class("HeroSkillView", ReduxView)
local var_0_1 = {
	PROPERTY = 2,
	SKILL = 1
}
local var_0_2 = {
	[var_0_1.SKILL] = "skill",
	[var_0_1.PROPERTY] = "property"
}

function HeroSkillView:UIName()
	return "Widget/System/Hero_skill/HeroSkillMainUI"
end

function HeroSkillView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroSkillView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroSkillView:InitUI()
	self:BindCfgUI()

	self.tabSelectController_ = self.tablistControllerEx_:GetController("tabSelect")
	self.propertyController_ = self.propertyControllerexcollection_:GetController("lock")
	self.hideTabController_ = self.controller_:GetController("hide")
	self.skillView_ = HeroSkillView.New(self, self.heroskilluiGo_)
	self.propertyObj_ = self.propertyBtn_.gameObject
end

function HeroSkillView:AddUIListener()
	self:AddBtnListener(self.skillBtn_, nil, function()
		self:ChangeTab(var_0_1.SKILL)
	end)
	self:AddBtnListener(self.propertyBtn_, nil, function()
		local var_7_0, var_7_1 = self:CheckPrepertyCondition(ViewConst.SYSTEM_ID.HERO_SKILL_ATTR)

		if not var_7_0 then
			ShowTips(var_7_1)

			return
		end

		OperationRecorder.RecordButtonTouch("hero_skill_attribute_lv_up")
		self:ChangeTab(var_0_1.PROPERTY)
	end)
end

function HeroSkillView:CheckPrepertyCondition(arg_8_1)
	if not table.keyof(ViewConst.SYSTEM_ID, arg_8_1) then
		return true, ""
	end

	local var_8_0 = JumpTools.IsSystemLocked(arg_8_1)

	if not var_8_0 then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(arg_8_1, var_8_0)
	end
end

function HeroSkillView:ChangeTab(arg_9_1)
	if self.selectTabType and self.selectTabType == arg_9_1 then
		return
	end

	self.tabSelectController_:SetSelectedState(var_0_2[arg_9_1])
	self:ExitSendMgr(self.selectTabType)

	self.selectTabType = arg_9_1

	self.skillView_:ChangeTabShow(arg_9_1)
	self:EnterSendMgr(self.selectTabType)
end

function HeroSkillView:NotHaveAttrShow(arg_10_1)
	SetActive(self.propertyObj_, not arg_10_1)

	if arg_10_1 and self.selectTabType == var_0_1.PROPERTY then
		self:ChangeTab(var_0_1.SKILL)
	end
end

function HeroSkillView:isPropertyView()
	return self.selectTabType == var_0_1.PROPERTY
end

function HeroSkillView:GetSelectTabType()
	return self.selectTabType
end

function HeroSkillView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if self.skillView_ then
		self.skillView_:OnTop()
	end
end

function HeroSkillView:OnEnter()
	self.skillView_:OnEnter(self.params_)

	self.heroViewDataProxy_ = self.params_.proxy

	self.hideTabController_:SetSelectedState(tostring(self.heroViewDataProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))

	if not self.selectTabType or self.heroViewDataProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		self:ChangeTab(var_0_1.SKILL)
	else
		self:EnterSendMgr(self.selectTabType)
	end

	self:CheckLocked()
	self:UpdateAvatarView()
end

function HeroSkillView:CheckLocked()
	local var_15_0, var_15_1 = self:CheckPrepertyCondition(ViewConst.SYSTEM_ID.HERO_SKILL_ATTR)

	self.propertyController_:SetSelectedState(var_15_0 and "false" or "true")
end

function HeroSkillView:UpdateAvatarView()
	if self.params_ and self.params_.heroInfo then
		local var_16_0 = self.params_.heroInfo.id or nil

		if var_16_0 then
			manager.heroRaiseTrack:SetModelStateByHeroProxy(self.heroViewDataProxy_, var_16_0)
		end
	end
end

function HeroSkillView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		1
	})
	manager.heroRaiseTrack:SetModelStateByHeroProxy(self.params_.proxy, self.params_.heroInfo.id)
end

function HeroSkillView:OnExit()
	manager.windowBar:HideBar()
	self.skillView_:OnExit()

	if self.skillView_ and self.skillView_.isGoHeroMain then
		self:ChangeTab(var_0_1.SKILL)
	end

	self:ExitSendMgr(self.selectTabType)
end

function HeroSkillView:OnHeroSkillUpgrade(arg_19_1, arg_19_2)
	self.skillView_:OnHeroSkillUpgrade(arg_19_1, arg_19_2)
end

function HeroSkillView:OnHeroSkillAttrUpgrade(arg_20_1, arg_20_2)
	self.skillView_:OnHeroSkillAttrUpgradeInView(arg_20_1, arg_20_2)
end

function HeroSkillView:GetPlayBackwardsAnimator()
	return self.skillView_:GetPlayBackwardsAnimator()
end

function HeroSkillView:Dispose()
	self.skillView_:Dispose()
	HeroSkillView.super.Dispose(self)
end

function HeroSkillView:EnterSendMgr(arg_23_1)
	if arg_23_1 then
		manager.uiTime:OnEnterRoute(var_0_2[arg_23_1])
	end
end

function HeroSkillView:ExitSendMgr(arg_24_1)
	if arg_24_1 then
		manager.uiTime:OnExitRoute(var_0_2[arg_24_1])
	end
end

return HeroSkillView
