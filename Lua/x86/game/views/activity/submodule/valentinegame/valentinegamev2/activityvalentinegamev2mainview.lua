ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityValentineGameV2MainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_VALENTINE_DESCRIBE"

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineActivityMainUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/valentineGameV2SelectHeroView", {
			activityID = ActivityConst.INDIA_VALENTINE_GAME_V2
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.infoBtn_, nil, function()
		local var_4_0 = GetTips(var_0_1)

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_4_0,
			key = var_0_1
		})
	end)
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.btn_.transform, RedPointConst.VALENTINE_GAME .. "_" .. arg_5_0.activityID_)
end

function var_0_0.OnExit(arg_6_0)
	var_0_0.super.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.btn_.transform, RedPointConst.VALENTINE_GAME .. "_" .. arg_6_0.activityID_)
end

return var_0_0
