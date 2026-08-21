ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("LimitedCalculationPageView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactMainUI"
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
		ActivityTools.JumpToSubmodulePage(arg_4_0.activityID_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		local var_6_0 = LimitedCalculationTools.GetGameHelpKey(arg_4_0.activiytID_)

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_6_0),
			key = var_6_0
		})
	end)
end

return var_0_0
