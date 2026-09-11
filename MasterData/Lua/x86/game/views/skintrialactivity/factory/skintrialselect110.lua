local SkinTrialSelect110 = class("SkinTrialSelect110", SkinTrialActivitySelectView)

function SkinTrialSelect110:UIName()
	return "UI/MardukUI/skinTrial/MardukSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect110:OnEnter()
	SkinTrialSelect110.super.OnEnter(self)

	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)

	self:AddTimer()
end

function SkinTrialSelect110:AddListeners()
	self:AddBtnListener(self.btnBattle_, nil, function()
		SkinTrialData:SaveStageID(self.skinTrialID_)

		if not ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		self:SaveRoute()
		self:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[self.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = self.activityID_
		})
	end)
end

function SkinTrialSelect110:OnExit()
	SkinTrialSelect110.super.OnExit(self)
	self:StopTimer()
end

function SkinTrialSelect110:RefreshUI()
	local var_6_0 = SkinTrialTools.GetHeroStandardID(self.skinTrialID_)

	self.heroNameText_.text = HeroTools.GetHeroFullName(HeroStandardSystemCfg[var_6_0].hero_id)
	self.skinDescText_.text = GetI18NText(SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].desc)

	self:RefreshReward()
end

function SkinTrialSelect110:GetRewardItem()
	return FactorySkinTrialRewardItem
end

function SkinTrialSelect110:GetCommonItem(arg_8_1)
	return arg_8_1:GetCommonItem()
end

function SkinTrialSelect110:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.rewardCfg_[arg_9_1], self.popType_, self.skinTrialID_)
end

function SkinTrialSelect110:AddTimer()
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

function SkinTrialSelect110:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SkinTrialSelect110
