local ActivityTools = import("game.tools.ActivityTools")
local SummerRaceConst = import("game.views.activity.Submodule.SummerRace.SummerRaceConst")
local SummerRaceLimitRewardEntryView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceLimitRewardEntryView")
local ActivitySummerRaceGamePage = class("ActivitySummerRaceGamePage", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

local function var_0_4()
	return SummerRaceConst.ACTIVITY_ID.MAIN
end

local function var_0_5()
	return SummerRaceConst.ACTIVITY_ID.RESIDENT
end

local function var_0_6()
	local var_3_0 = var_0_4()

	return string.format("%s%s", ActivityTools.GetRedPointKey(var_3_0), var_3_0)
end

local function var_0_7()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_LIMIT_TASK, var_0_4())
end

function ActivitySummerRaceGamePage:GetUIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_HomeUI"
end

function ActivitySummerRaceGamePage:Init()
	ActivitySummerRaceGamePage.super.Init(self)

	self.limitRewardController_ = self.controller_:GetController("limitReward")
	self.limitRewardEntryView_ = SummerRaceLimitRewardEntryView.New(self.limitedRewardEntryGo_)

	self.limitRewardEntryView_:SetClickHandler(function()
		SummerRaceAction.OpenRewardView(SummerRaceConst.REWARD_PAGE.LIMITED)
	end)
	self.limitRewardEntryView_:SetVisibleChangedHandler(function(arg_8_0)
		self.limitRewardController_:SetSelectedState(arg_8_0 and "show" or "hide")
	end)
end

function ActivitySummerRaceGamePage:OnEnter()
	SummerRaceData:EnsureFrameworkRedPoints()
	SummerRaceData:RefreshFrameworkRedPoints()

	self.rewardActivityID_ = SummerRaceData:GetRewardRootActivityId()

	self:RefreshActivityPage()
	ActivitySummerRaceGamePage.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, var_0_6())
	manager.redPoint:bindUIandKey(self.limitRewardEntryView_:GetBindingTransform(), var_0_7())
	self.limitRewardEntryView_:OnEnter()
end

function ActivitySummerRaceGamePage:OnExit()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, var_0_6())
	manager.redPoint:unbindUIandKey(self.limitRewardEntryView_:GetBindingTransform(), var_0_7())
	self.limitRewardEntryView_:OnExit()
	ActivitySummerRaceGamePage.super.OnExit(self)
end

function ActivitySummerRaceGamePage:Show(arg_11_1)
	ActivitySummerRaceGamePage.super.Show(self, arg_11_1)

	if arg_11_1 then
		self:RefreshActivityPage()
	end
end

function ActivitySummerRaceGamePage:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		SummerRaceAction.OpenMainView({
			playBodyDisplayOnEnter = true,
			playFirstPlotOnEnter = true
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		ChapterResidentTools.OpenResidentActTips(var_0_5())
	end)
end

function ActivitySummerRaceGamePage:AddTimer()
	return
end

function ActivitySummerRaceGamePage:RefreshActivityPage()
	SummerRaceData:RefreshFrameworkRedPoints()

	self.rewardActivityID_ = SummerRaceData:GetRewardRootActivityId()

	local var_16_0, var_16_1 = SummerRaceData:ResolveRewardEntryPage(SummerRaceConst.REWARD_PAGE.LIMITED)

	self.limitRewardEntryView_:SetData({
		activityId = self.rewardActivityID_,
		pageType = SummerRaceConst.REWARD_PAGE.LIMITED,
		subType = var_16_1
	})
end

function ActivitySummerRaceGamePage:Dispose()
	if self.limitRewardEntryView_ ~= nil then
		self.limitRewardEntryView_:Dispose()

		self.limitRewardEntryView_ = nil
	end

	ActivitySummerRaceGamePage.super.Dispose(self)
end

return ActivitySummerRaceGamePage
