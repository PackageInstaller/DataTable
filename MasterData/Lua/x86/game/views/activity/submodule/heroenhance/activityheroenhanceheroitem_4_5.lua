local ActivityHeroEnhanceHeroItem_4_5 = class("ActivityHeroEnhanceHeroItem_4_5", ReduxView)

function ActivityHeroEnhanceHeroItem_4_5:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function ActivityHeroEnhanceHeroItem_4_5:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller_:GetController("status")
	self.lockController_ = self.controller_:GetController("lock")
end

function ActivityHeroEnhanceHeroItem_4_5:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.onClickHandler_ then
			local var_4_0, var_4_1 = ActivityHeroEnhanceTools.IsCfgHeroLock(ActivityHeroEnhanceCfg[self.cfgId_])

			if var_4_0 then
				ShowTips(string.format(GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION_2"), (HeroTools.GetHeroFullName(ActivityHeroEnhanceTools.GetTutorialCfg(ActivityHeroEnhanceCfg[self.cfgId_].activity_id).hero_id))))

				return
			end

			self.onClickHandler_(self.cfgId_)
		end
	end)
end

function ActivityHeroEnhanceHeroItem_4_5:SetClickHandler(arg_5_1)
	if arg_5_1 then
		self.onClickHandler_ = arg_5_1
	end
end

function ActivityHeroEnhanceHeroItem_4_5:SetData(arg_6_1)
	self.cfgId_ = arg_6_1
end

function ActivityHeroEnhanceHeroItem_4_5:SetSelected(arg_7_1)
	self.selected_ = arg_7_1

	self:RefreshUI()
end

function ActivityHeroEnhanceHeroItem_4_5:RefreshUI()
	local var_8_0 = ActivityHeroEnhanceCfg[self.cfgId_].activity_id
	local var_8_1 = ActivityHeroEnhanceCfg[self.cfgId_].hero_id
	local var_8_2 = HeroData:GetHeroData(ActivityHeroEnhanceCfg[self.cfgId_].hero_id)

	self.headIcon1_.sprite = HeroTools.GetHeadSprite(ActivityHeroEnhanceCfg[self.cfgId_].hero_id)
	self.nameText1_.text = HeroTools.GetHeroFullName(var_8_1)
	self.headIcon2_.sprite = HeroTools.GetHeadSprite(var_8_1)
	self.nameText2_.text = HeroTools.GetHeroFullName(var_8_1)

	local var_8_4, var_8_5 = ActivityHeroEnhanceTools.IsCfgHeroLock(ActivityHeroEnhanceCfg[self.cfgId_])

	self.selController_:SetSelectedState(self.selected_ and "select" or "nomal")
	self.lockController_:SetSelectedState((self.isAni_ or var_8_4) and "true" or "false")

	if var_8_4 then
		if var_8_5.isBeforeStartDay then
			local var_8_6 = GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION")
		else
			local var_8_7 = HeroTools.GetHeroFullName(ActivityHeroEnhanceTools.GetTutorialCfg(var_8_0).hero_id)
		end
	elseif not (getData("heroEnhanceHeroUnlock" .. var_8_0, tostring(var_8_1)) or false) then
		saveData("heroEnhanceHeroUnlock" .. var_8_0, tostring(var_8_1), true)
		SetActive(self.effectGo_, true)
	else
		SetActive(self.effectGo_, false)
	end
end

function ActivityHeroEnhanceHeroItem_4_5:PlayAnim(arg_9_1)
	self.lockController_:SetSelectedState("true")

	self.animator_.enabled = true

	self.animator_:Play("UI_jiesuo", 0, 0)

	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self.aniTimer_ = Timer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self.animator_.enabled = false

			if self.aniTimer_ then
				self.aniTimer_:Stop()

				self.aniTimer_ = nil
			end

			if arg_9_1 then
				arg_9_1()
			end

			self.lockController_:SetSelectedState("false")
			manager.ui:UIEventEnabledByUI(true, false)
		end
	end, 0.033, -1)

	manager.ui:UIEventEnabledByUI(false, true)

	self.isAni_ = true

	self.aniTimer_:Start()
end

function ActivityHeroEnhanceHeroItem_4_5:GetRedPointTransform()
	return self.selfBtn_.transform
end

function ActivityHeroEnhanceHeroItem_4_5:GetCfgId()
	return self.cfgId_
end

function ActivityHeroEnhanceHeroItem_4_5:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	ActivityHeroEnhanceHeroItem_4_5.super.Dispose(self)
end

return ActivityHeroEnhanceHeroItem_4_5
