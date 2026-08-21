local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("BlisterGameEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGameMainUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/blisterGame_4_3", {
			activityID = ActivityConst.ACTIVITY_BLISTER_4_3
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			key = "ACTIVITY_BLISTER_DESCRIPE",
			content = GetTips("ACTIVITY_BLISTER_DESCRIPE")
		})
	end)
end

function var_0_1.OnEnter(arg_7_0)
	var_0_1.super.OnEnter(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, ActivityConst.ACTIVITY_BLISTER_4_3))
end

function var_0_1.OnExit(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, ActivityConst.ACTIVITY_BLISTER_4_3))
	var_0_1.super.OnExit(arg_8_0)
end

return var_0_1
