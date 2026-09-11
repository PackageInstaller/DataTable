SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")

local FactorySkinTrialActivityItem = class("FactorySkinTrialActivityItem", SkinTrialActivityItem)

function FactorySkinTrialActivityItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")

	self:SetSkinTrialID(arg_1_2)
	SetActive(self.gameObject_, true)
end

function FactorySkinTrialActivityItem:RefreshUI()
	if SDKTools.GetIsOverSea() then
		local var_2_0 = getSpriteViaConfig("SkinTrialTextrues", string.format("%s_oversea", HeroStandardSystemCfg[ActivitySkinTrialCfg[self.skinTrialID_].trial_id].skin_id))

		if var_2_0 ~= nil then
			self.skinImage_.sprite = var_2_0
		end

		self.skinNameText_.text = GetI18NText(ActivitySkinTrialCfg[self.skinTrialID_].name)
		self.heroNameText_.text = HeroTools.GetHeroFullName(HeroStandardSystemCfg[ActivitySkinTrialCfg[self.skinTrialID_].trial_id].hero_id)
	end

	if SkinTrialData:IsCompleted(self.skinTrialID_) then
		self.stateController_:SetSelectedState("true")
	end
end

function FactorySkinTrialActivityItem:AddListeners()
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

		if self.path_ == nil then
			self.path_ = string.format("/skinTrialSelect%d", self.skinTrialID_)
		end

		self:Go(self.path_, {
			canPlayAnim = true,
			activityID = self.activityID_,
			skinTrialID = self.skinTrialID_
		})
	end)
end

return FactorySkinTrialActivityItem
