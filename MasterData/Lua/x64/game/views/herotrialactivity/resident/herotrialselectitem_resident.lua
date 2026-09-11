local HeroTrialSelectItem_Resident = class("HeroTrialSelectItem_Resident", ReduxView)

function HeroTrialSelectItem_Resident:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
	self:SetActivityHeroID(arg_1_4, arg_1_3)
end

function HeroTrialSelectItem_Resident:Init()
	self:InitUI()
	self:AddListeners()
end

function HeroTrialSelectItem_Resident:InitUI()
	self:BindCfgUI()

	self.heroHeadIcon_.immediate = true
	self.selectController_ = self.controllerEx_:GetController("select")
	self.completeController_ = self.controllerEx_:GetController("complete")
end

function HeroTrialSelectItem_Resident:Dispose()
	HeroTrialSelectItem_Resident.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[self.acitvityTrialID_].id)))
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function HeroTrialSelectItem_Resident:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.acitvityTrialID_)
		manager.notify:Invoke(HERO_TRIAL_CLICK, self.acitvityTrialID_)
	end)
end

function HeroTrialSelectItem_Resident:SetActivityHeroID(arg_7_1, arg_7_2)
	if self.acitvityTrialID_ == nil then
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_7_2].id)))
	elseif self.acitvityTrialID_ ~= arg_7_2 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[self.acitvityTrialID_].id)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_7_2].id)))
	end

	self.acitvityTrialID_ = arg_7_2
	self.activityID_ = arg_7_1

	self:RefreshUI()
end

function HeroTrialSelectItem_Resident:RefreshUI()
	local var_8_0 = HeroTrialTools.GetHeroStandardID(self.acitvityTrialID_)

	self.heroHeadIcon_.spriteSync = SpritePathCfg.HeroLittleIcon.path .. SkinCfg[HeroStandardSystemCfg[var_8_0].skin_id].picture_id
	self.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[HeroStandardSystemCfg[var_8_0].hero_id].race].icon)

	self:RefreshComplete()
end

function HeroTrialSelectItem_Resident:OnSelect(arg_9_1)
	self.selectController_:SetSelectedState(tostring(self.acitvityTrialID_ == arg_9_1))
end

function HeroTrialSelectItem_Resident:RefreshComplete()
	if self.completeController_ then
		self.completeController_:SetSelectedState(tostring(HeroTrialData:GetHeroTrialStateList()[self.acitvityTrialID_] ~= 0))
	end
end

return HeroTrialSelectItem_Resident
