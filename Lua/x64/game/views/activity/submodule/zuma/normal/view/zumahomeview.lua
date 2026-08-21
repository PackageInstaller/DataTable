ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ZumaHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaMainUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/springFestivalZumaMainView", {})
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.descBtn_, function()
		local var_4_0 = "ACTIVITY_ZUMA_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_4_0),
			key = var_4_0
		})
	end)
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)
	ZumaData:SetZumaActivityID(arg_5_0.activityID_)
	manager.redPoint:bindUIandKey(arg_5_0.btnstartBtn_.transform, RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA)
end

function var_0_0.OnExit(arg_6_0)
	var_0_0.super.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.btnstartBtn_.transform, RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA)
end

return var_0_0
