local SkinTrialSelectItem_2_0 = class("SkinTrialSelectItem_2_0", ReduxView)

function SkinTrialSelectItem_2_0:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.skinImage_.immediate = true

	self:AddListeners()
end

function SkinTrialSelectItem_2_0:Dispose()
	SkinTrialSelectItem_2_0.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SKIN_TRIAL, self.skinTrialID_)))

	self.outOfDataHandler_ = nil
end

function SkinTrialSelectItem_2_0:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		SkinTrialData:SetSelectSkinTrialID(self.skinTrialID_)
		SkinTrialTools.GoToSelectView(self.activityID_, self.skinTrialID_)
	end)
end

function SkinTrialSelectItem_2_0:SetSkinTrialID(arg_5_1)
	manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_5_1)))

	self.skinTrialID_ = arg_5_1
	self.activityID_ = ActivitySkinTrialCfg[self.skinTrialID_].activity_id
	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
	self:RefreshTime()
end

function SkinTrialSelectItem_2_0:RefreshUI()
	local var_6_0 = SkinTrialTools.GetHeroStandardID(self.skinTrialID_)

	self.heroNameText_.text = HeroTools.GetHeroFullName(HeroStandardSystemCfg[var_6_0].hero_id)
	self.nameText_.text = SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].name
	self.skinImage_.spriteSync = getSpritePathViaConfig("HeroIcon", SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].picture_id)
end

function SkinTrialSelectItem_2_0:RefreshTime()
	if manager.time:GetServerTime() < self.startTime_ or manager.time:GetServerTime() >= self.stopTime_ then
		SetActive(self.gameObject_, false)
		self.outOfDataHandler_()

		return
	end

	SetActive(self.gameObject_, true)

	self.textTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_)
end

function SkinTrialSelectItem_2_0:SetOutOfDataHandler(arg_8_1)
	self.outOfDataHandler_ = arg_8_1
end

return SkinTrialSelectItem_2_0
