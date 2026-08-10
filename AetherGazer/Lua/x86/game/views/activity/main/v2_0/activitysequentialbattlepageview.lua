ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivitySequentialBattlePageView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	local var_1_0 = SequentialBattleUICfg.get_id_list_by_main_activity_id[arg_1_0.activityID_][1]

	return SequentialBattleUICfg[var_1_0].entrance_prefab
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	manager.redPoint:bindUIandKey(arg_2_0.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_2_0.activityID_), arg_2_0.activityID_))
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_3_0.activityID_), arg_3_0.activityID_))
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/sequentialBattleFactory", {
			activityID = arg_4_0.activityID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("SEQUENTIAL_BATTLE_DESC"),
			key = key
		})
	end)
end

function var_0_0.isHasLeftTimeDes(arg_7_0)
	return true
end

return var_0_0
