local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("MoonCakeEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeEnterUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.OnEnter(arg_4_0)
	var_0_1.super.OnEnter(arg_4_0)
	arg_4_0:RefreshStage()

	local var_4_0 = string.format("%s_%s", RedPointConst.MOON_CAKE, arg_4_0.activityID_)

	manager.redPoint:bindUIandKey(arg_4_0.enterBtn_.transform, var_4_0)
	arg_4_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_4_0, arg_4_0.OnActivityUpdate))
end

function var_0_1.OnExit(arg_5_0)
	var_0_1.super.OnExit(arg_5_0)

	local var_5_0 = string.format("%s_%s", RedPointConst.MOON_CAKE, arg_5_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_5_0.enterBtn_.transform, var_5_0)
	arg_5_0:RemoveAllEventListener()
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.enterBtn_, nil, function()
		if not arg_6_0:IsActivityTime() then
			return
		end

		if arg_6_0.isPartyOpen_ then
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = arg_6_0.partyActivityID_,
				mainActivityID = arg_6_0.activityID_,
				partyOwnerUID = USER_ID
			})
		elseif arg_6_0.isCakeOpen_ then
			JumpTools.OpenPageByJump("/moonCakeMain", {
				activityID = arg_6_0.cakeActivityID_,
				mainActivityID = arg_6_0.activityID_
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		local var_8_0 = GetTips("MID_AUTUMN_FESTIVAL_DESCRIPTION")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "MID_AUTUMN_FESTIVAL_DESCRIPTION",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_8_0
		})
	end)
end

function var_0_1.RefreshStage(arg_9_0)
	arg_9_0.cakeActivityID_ = MoonCakeTools.GetCakeStageActivityID(arg_9_0.activityID_)

	local var_9_0 = ActivityData:GetActivityData(arg_9_0.cakeActivityID_)

	arg_9_0.cakeStartTime_ = var_9_0.startTime
	arg_9_0.cakeStopTime_ = var_9_0.stopTime

	local var_9_1 = manager.time:GetServerTime()

	arg_9_0.isCakeOpen_ = var_9_1 >= arg_9_0.cakeStartTime_ and var_9_1 < arg_9_0.cakeStopTime_
	arg_9_0.partyActivityID_ = MoonCakeTools.GetPartyStageActivityID(arg_9_0.activityID_)

	local var_9_2 = ActivityData:GetActivityData(arg_9_0.partyActivityID_)

	arg_9_0.partyStartTime_ = var_9_2.startTime
	arg_9_0.partyStopTime_ = var_9_2.stopTime
	arg_9_0.isPartyOpen_ = var_9_1 >= arg_9_0.partyStartTime_ and var_9_1 < arg_9_0.partyStopTime_
end

function var_0_1.OnActivityUpdate(arg_10_0, arg_10_1)
	local var_10_0 = ActivityTools.GetActivityType(arg_10_1)

	if var_10_0 == ActivityTemplateConst.MOON_CAKE_MAKE or var_10_0 == ActivityTemplateConst.MOON_CAKE_PARTY then
		arg_10_0:RefreshStage()
	end
end

return var_0_1
