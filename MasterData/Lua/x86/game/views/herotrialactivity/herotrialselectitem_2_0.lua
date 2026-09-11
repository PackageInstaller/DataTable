local HeroTrialSelectItem_2_0 = class("HeroTrialSelectItem_2_0", ReduxView)

function HeroTrialSelectItem_2_0:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.imageSelect_.immediate = true
	self.imageIcon_.immediate = true

	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "name")
	self.completeController_ = ControllerUtil.GetController(self.transform_, "complete")

	self:SetActivityHeroID(arg_1_4, arg_1_3)
	SetActive(self.gameObject_, true)
end

function HeroTrialSelectItem_2_0:Dispose()
	HeroTrialSelectItem_2_0.super.Dispose(self)

	local var_2_0 = string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[self.acitvityTrialID_].id)

	manager.redPoint:unbindUIandKey(self.transformBtn1_, var_2_0)
	manager.redPoint:unbindUIandKey(self.transformBtn2_, var_2_0)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function HeroTrialSelectItem_2_0:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.acitvityTrialID_)
		manager.notify:Invoke(HERO_TRIAL_CLICK, self.acitvityTrialID_)
	end)
end

function HeroTrialSelectItem_2_0:SetActivityHeroID(arg_5_1, arg_5_2)
	if self.acitvityTrialID_ == nil then
		local var_5_0 = string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_5_2].id)

		manager.redPoint:bindUIandKey(self.transformBtn1_, var_5_0)
		manager.redPoint:bindUIandKey(self.transformBtn2_, var_5_0)
	elseif self.acitvityTrialID_ ~= arg_5_2 then
		local var_5_1 = string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[self.acitvityTrialID_].id)

		manager.redPoint:unbindUIandKey(self.transformBtn1_, var_5_1)
		manager.redPoint:unbindUIandKey(self.transformBtn2_, var_5_1)

		local var_5_2 = string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_5_2].id)

		manager.redPoint:bindUIandKey(self.transformBtn1_, var_5_2)
		manager.redPoint:bindUIandKey(self.transformBtn2_, var_5_2)
	end

	self.acitvityTrialID_ = arg_5_2
	self.activityID_ = arg_5_1

	self:RefreshUI()
end

function HeroTrialSelectItem_2_0:RefreshUI()
	local var_6_0 = HeroTrialTools.GetHeroStandardID(self.acitvityTrialID_)
	local var_6_1 = getSpritePathViaConfig("HeroIcon", SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].picture_id)

	self.imageSelect_.spriteSync = var_6_1
	self.imageIcon_.spriteSync = var_6_1
	self.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].race].icon)
	self.imageRaceSelect_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].race].icon)

	self:RefreshComplete()
end

function HeroTrialSelectItem_2_0:OnSelect(arg_7_1)
	if self.acitvityTrialID_ == arg_7_1 then
		self.selectController_:SetSelectedState("Select")
	else
		self.selectController_:SetSelectedState("no")
	end
end

function HeroTrialSelectItem_2_0:RefreshComplete()
	if self.completeController_ then
		self.completeController_:SetSelectedState(tostring(HeroTrialData:GetHeroTrialStateList()[self.acitvityTrialID_] ~= 0))
	end
end

return HeroTrialSelectItem_2_0
