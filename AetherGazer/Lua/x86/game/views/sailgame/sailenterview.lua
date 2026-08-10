local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("SailEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesHomeUI"
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

	local var_4_0 = string.format("%s_%s", RedPointConst.SAIL_GAME, arg_4_0.activityID_)

	manager.redPoint:bindUIandKey(arg_4_0.goBtn_.transform, var_4_0)
end

function var_0_1.OnExit(arg_5_0)
	var_0_1.super.OnExit(arg_5_0)

	local var_5_0 = string.format("%s_%s", RedPointConst.SAIL_GAME, arg_5_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_5_0.goBtn_.transform, var_5_0)
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		if not arg_6_0:IsActivityTime() then
			return
		end

		SailGameData:SetSelectedMainBtn(arg_6_0.activityID_)
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = arg_6_0.activityID_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		local var_8_0 = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKADI_SEA_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_8_0
		})
	end)
end

return var_0_1
