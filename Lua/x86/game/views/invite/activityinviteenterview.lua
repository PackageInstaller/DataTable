local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivityInviteEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionConMainUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.OnEnter(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(InviteData:GetDataByPara("activityId"))

	arg_4_0.startTime_ = var_4_0.startTime
	arg_4_0.stopTime_ = var_4_0.stopTime

	arg_4_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_4_0.goBtn_.transform, RedPointConst.INVITE_MAIN, {
		x = 150,
		y = 35
	})

	arg_4_0.descTxt_.text = GetTips("ACTIVITY_INVITE_DECORATE")
end

function var_0_1.OnExit(arg_5_0)
	var_0_1.super.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.goBtn_.transform, RedPointConst.INVITE_MAIN)
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		local var_7_0 = InviteData:GetDataByPara("selectHeroIndex")

		if InviteData:GetDataByPara("allComplete") then
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = 1
			})
		elseif var_7_0 then
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = var_7_0
			})
		else
			JumpTools.GoToSystem("/ActivityInviteMain", {})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_INVITE_DESCRIPTION")
		})
	end)
end

return var_0_1
