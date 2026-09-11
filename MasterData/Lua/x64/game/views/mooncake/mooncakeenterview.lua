local MoonCakeEnterView = class("MoonCakeEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function MoonCakeEnterView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeEnterUI"
end

function MoonCakeEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakeEnterView:InitUI()
	self:BindCfgUI()
end

function MoonCakeEnterView:OnEnter()
	MoonCakeEnterView.super.OnEnter(self)
	self:RefreshStage()
	manager.redPoint:bindUIandKey(self.enterBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_CAKE, self.activityID_)))
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function MoonCakeEnterView:OnExit()
	MoonCakeEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.enterBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_CAKE, self.activityID_)))
	self:RemoveAllEventListener()
end

function MoonCakeEnterView:AddUIListener()
	self:AddBtnListener(self.enterBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		if self.isPartyOpen_ then
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = self.partyActivityID_,
				mainActivityID = self.activityID_,
				partyOwnerUID = USER_ID
			})
		elseif self.isCakeOpen_ then
			JumpTools.OpenPageByJump("/moonCakeMain", {
				activityID = self.cakeActivityID_,
				mainActivityID = self.activityID_
			})
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "MID_AUTUMN_FESTIVAL_DESCRIPTION",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("MID_AUTUMN_FESTIVAL_DESCRIPTION")
		})
	end)
end

function MoonCakeEnterView:RefreshStage()
	self.cakeActivityID_ = MoonCakeTools.GetCakeStageActivityID(self.activityID_)

	local var_9_0 = ActivityData:GetActivityData(self.cakeActivityID_)

	self.cakeStartTime_ = var_9_0.startTime
	self.cakeStopTime_ = var_9_0.stopTime

	local var_9_1 = manager.time:GetServerTime()

	self.isCakeOpen_ = var_9_1 >= self.cakeStartTime_ and var_9_1 < self.cakeStopTime_
	self.partyActivityID_ = MoonCakeTools.GetPartyStageActivityID(self.activityID_)

	local var_9_2 = ActivityData:GetActivityData(self.partyActivityID_)

	self.partyStartTime_ = var_9_2.startTime
	self.partyStopTime_ = var_9_2.stopTime
	self.isPartyOpen_ = var_9_1 >= self.partyStartTime_ and var_9_1 < self.partyStopTime_
end

function MoonCakeEnterView:OnActivityUpdate(arg_10_1)
	local var_10_0 = ActivityTools.GetActivityType(arg_10_1)

	if var_10_0 == ActivityTemplateConst.MOON_CAKE_MAKE or var_10_0 == ActivityTemplateConst.MOON_CAKE_PARTY then
		self:RefreshStage()
	end
end

return MoonCakeEnterView
