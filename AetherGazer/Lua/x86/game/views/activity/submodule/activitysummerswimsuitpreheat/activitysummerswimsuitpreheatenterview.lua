local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivitySummerSwimsuitPreheatEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatMainUI"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	arg_2_0.playBtnText_.text = GetTips("SUMMER_PREHEAT_ENTER")
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/activitySummerSwimsuitPreheatMain", {
			activityID = arg_3_0.activityID_
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.descBtn_, nil, function()
		local var_5_0 = "ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_5_0),
			key = var_5_0
		})
	end)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)

	local var_6_0 = arg_6_0.activityID_
	local var_6_1 = ActivityTools.GetRedPointKey(var_6_0) .. var_6_0
	local var_6_2 = string.format("%s_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT, var_6_1)

	manager.redPoint:bindUIandKey(arg_6_0.goBtn_.transform, var_6_2)
	arg_6_0:RefreshUI()
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)

	local var_7_0 = arg_7_0.activityID_
	local var_7_1 = ActivityTools.GetRedPointKey(var_7_0) .. var_7_0
	local var_7_2 = string.format("%s_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT, var_7_1)

	manager.redPoint:unbindUIandKey(arg_7_0.goBtn_.transform, var_7_2)
end

function var_0_1.RefreshUI(arg_8_0)
	return
end

function var_0_1.Dispose(arg_9_0)
	var_0_1.super.Dispose(arg_9_0)
end

return var_0_1
