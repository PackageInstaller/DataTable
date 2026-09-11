local SummerRaceConst = import("game.views.activity.Submodule.SummerRace.SummerRaceConst")
local SummerRaceLimitRewardEntryView = class("SummerRaceLimitRewardEntryView", ReduxView)

local function var_0_2(arg_1_0)
	local var_1_0 = tonumber(arg_1_0) or 0

	if var_1_0 == 0 then
		return "", false
	end

	local var_1_1 = ActivityData:GetActivityData(var_1_0)

	if var_1_1 == nil then
		return "", false
	end

	if ActivityData:GetActivityIsOpen(var_1_0) then
		return manager.time:GetLostTimeStr2(var_1_1.stopTime), true
	end

	if manager.time:GetServerTime() < var_1_1.startTime then
		return string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_1_1.startTime)), true
	end

	return GetTips("TIME_OVER"), false
end

local function var_0_3(arg_2_0)
	if arg_2_0.rewardBtn_ == nil then
		return arg_2_0.transform_
	end

	return arg_2_0.rewardBtn_.transform
end

function SummerRaceLimitRewardEntryView:OnCtor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SummerRaceLimitRewardEntryView:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.clickHandler_ ~= nil and self.isVisible_ == true then
			self.clickHandler_(self.pageType_, self.subType_)
		end
	end)
end

function SummerRaceLimitRewardEntryView:SetClickHandler(arg_6_1)
	self.clickHandler_ = arg_6_1
end

function SummerRaceLimitRewardEntryView:SetCountdownText(arg_7_1)
	self.countdownText_ = arg_7_1 or ""

	if self.timeText_ ~= nil then
		self.timeText_.text = self.countdownText_
	end
end

function SummerRaceLimitRewardEntryView:SetVisible(arg_8_1)
	self.isVisible_ = arg_8_1 == true

	if self.visibilityChangedHandler_ ~= nil then
		self.visibilityChangedHandler_(self.isVisible_)
	end
end

function SummerRaceLimitRewardEntryView:SetVisibleChangedHandler(arg_9_1)
	self.visibilityChangedHandler_ = arg_9_1
end

function SummerRaceLimitRewardEntryView:GetBindingTransform()
	return var_0_3(self)
end

function SummerRaceLimitRewardEntryView:SetData(arg_11_1)
	local var_11_0 = arg_11_1 or {}

	self.activityId_ = tonumber(var_11_0.activityId) or 0
	self.pageType_ = var_11_0.pageType or SummerRaceConst.REWARD_PAGE.LIMITED
	self.subType_ = var_11_0.subType or SummerRaceConst.REWARD_SUBTYPE.DAILY

	if self.active_ == true then
		self:RefreshCountdown()
	end
end

function SummerRaceLimitRewardEntryView:OnEnter()
	self.active_ = true

	self:RefreshCountdown()
	self:StartTimer()
end

function SummerRaceLimitRewardEntryView:OnExit()
	self.active_ = false

	self:StopTimer()
end

function SummerRaceLimitRewardEntryView:RefreshCountdown()
	local var_14_0, var_14_1 = var_0_2(self.activityId_)

	self:SetVisible(var_14_1)
	self:SetCountdownText(var_14_0)
	SetActive(self.gameObject_, self.isVisible_)
end

function SummerRaceLimitRewardEntryView:StartTimer()
	self:StopTimer()

	if self.activityId_ == nil or self.activityId_ == 0 then
		return
	end

	self.timer_ = Timer.New(function()
		self:RefreshCountdown()
	end, 1, -1)

	self.timer_:Start()
end

function SummerRaceLimitRewardEntryView:StopTimer()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SummerRaceLimitRewardEntryView:Dispose()
	self:StopTimer()
	SummerRaceLimitRewardEntryView.super.Dispose(self)
end

return SummerRaceLimitRewardEntryView
