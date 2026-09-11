local HeroTrialActivityItem = class("HeroTrialActivityItem", ReduxView)

function HeroTrialActivityItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self:SetActivityHeroID(arg_1_4, arg_1_3)
	SetActive(self.gameObject_, true)
end

function HeroTrialActivityItem:Dispose()
	HeroTrialActivityItem.super.Dispose(self)

	local var_2_0 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[self.acitviteTrialID_].activity_id, ActivityHeroTrialCfg[self.acitviteTrialID_].id)

	manager.redPoint:unbindUIandKey(self.transformBtn1_, var_2_0)
	manager.redPoint:unbindUIandKey(self.transformBtn2_, var_2_0)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function HeroTrialActivityItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.acitviteTrialID_)
		manager.notify:Invoke(HERO_TRIAL_CLICK)
	end)
end

function HeroTrialActivityItem:SetActivityHeroID(arg_5_1, arg_5_2)
	if self.acitviteTrialID_ == nil then
		local var_5_0 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_5_2].activity_id, ActivityHeroTrialCfg[arg_5_2].id)

		manager.redPoint:bindUIandKey(self.transformBtn1_, var_5_0)
		manager.redPoint:bindUIandKey(self.transformBtn2_, var_5_0)
	elseif self.acitviteTrialID_ ~= arg_5_2 then
		local var_5_1 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[self.acitviteTrialID_].activity_id, ActivityHeroTrialCfg[self.acitviteTrialID_].id)

		manager.redPoint:unbindUIandKey(self.transformBtn1_, var_5_1)
		manager.redPoint:unbindUIandKey(self.transformBtn2_, var_5_1)

		local var_5_2 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_5_2].activity_id, ActivityHeroTrialCfg[arg_5_2].id)

		manager.redPoint:bindUIandKey(self.transformBtn1_, var_5_2)
		manager.redPoint:bindUIandKey(self.transformBtn2_, var_5_2)
	end

	self.acitviteTrialID_ = arg_5_2
	self.activityID_ = arg_5_1

	self:RefreshUI()
end

function HeroTrialActivityItem:RefreshUI()
	local var_6_0 = HeroTrialTools.GetHeroStandardID(self.acitviteTrialID_)

	self.textName1_.text = string.format("%s·%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].suffix))
	self.textName2_.text = string.format("%s·%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].suffix))
	self.imageSelect_.sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].picture_id)
	self.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].picture_id)
end

function HeroTrialActivityItem:OnSelect(arg_7_1)
	if self.acitviteTrialID_ == arg_7_1 then
		self.controller_:SetSelectedState("Select")
	else
		self.controller_:SetSelectedState("no")
	end
end

return HeroTrialActivityItem
