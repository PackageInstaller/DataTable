local SkinTrialSelect1001 = class("SkinTrialSelect1001", SkinTrialActivitySelectView)

function SkinTrialSelect1001:UIName()
	return "UI/OsirisUI/OsirisSkinTrialUI_101"
end

function SkinTrialSelect1001:OnEnter()
	SkinTrialSelect1001.super.OnEnter(self)

	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
end

function SkinTrialSelect1001:AddListeners()
	self:AddBtnListener(self.btnBattle_, nil, function()
		SkinTrialData:SaveStageID(self.skinTrialID_)

		if not ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		self:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[self.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = self.activityID_
		})
	end)
end

function SkinTrialSelect1001:OnExit()
	SkinTrialSelect1001.super.OnExit(self)
	self:StopTimer()
end

function SkinTrialSelect1001:RefreshUI()
	local var_6_0 = SkinTrialTools.GetHeroStandardID(self.skinTrialID_)
	local var_6_1 = HeroStandardSystemCfg[var_6_0].skin_id

	self.heroTitleText_.text = GetI18NText(SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].name)
	self.skinImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[var_6_1].picture_id)
	self.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].suffix))

	local var_6_2 = SettingData:GetCurrentLanguage()

	if var_6_2 == "fr" or var_6_2 == "de" then
		self.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].suffix))
	end

	self.skinDescText_.text = GetI18NText(SkinCfg[var_6_1].desc)

	self:RefreshReward()
end

function SkinTrialSelect1001:GetRewardItem()
	return CommonItem
end

function SkinTrialSelect1001:GetCommonItem(arg_8_1)
	return arg_8_1
end

function SkinTrialSelect1001:IndexItem(arg_9_1, arg_9_2)
	local var_9_0 = self.rewardCfg_[arg_9_1]
	local var_9_1 = self:GetCommonItem(arg_9_2)

	var_9_1:RefreshData(formatReward(self.rewardCfg_[arg_9_1]))
	var_9_1:RegistCallBack(function()
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, var_9_0)
			end
		else
			ShowPopItem(self.popType_, var_9_0)
		end
	end)

	if self.receivedControllerList_[arg_9_1] == nil then
		self.receivedControllerList_[arg_9_1] = ControllerUtil.GetController(var_9_1.transform_, "received")
	end

	if SkinTrialData:IsCompleted(self.skinTrialID_) then
		self.receivedControllerList_[arg_9_1]:SetSelectedState("true")
	end
end

function SkinTrialSelect1001:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function SkinTrialSelect1001:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SkinTrialSelect1001
