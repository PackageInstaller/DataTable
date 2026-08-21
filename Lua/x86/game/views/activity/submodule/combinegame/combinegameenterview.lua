local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("CombineGameEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfMainUI"
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

	local var_4_0 = ActivityData:GetActivityData(CombineGameData:GetDataByPara("activityId"))

	arg_4_0.startTime_ = var_4_0.startTime
	arg_4_0.stopTime_ = var_4_0.stopTime

	arg_4_0:AddTimer()
end

function var_0_1.OnExit(arg_5_0)
	var_0_1.super.OnExit(arg_5_0)
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/CombineGameMainView", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		local var_8_0 = GetTips("COMBINE_GAME_EXPLAIN")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_8_0
		})
	end)
end

return var_0_1
