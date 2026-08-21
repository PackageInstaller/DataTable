ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("StrongholdHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdHomeUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_statrBtn, nil, function()
		if not arg_3_0:IsActivityTime() then
			return
		end

		JumpTools.GoToSystem("/cooperationBlank/strongholdMain")
	end)
	arg_3_0:AddBtnListener(arg_3_0.m_tipBtn, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_STRONGHOLD_DES"),
			key = arg_3_0.gameHelpKey
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	var_0_0.super.OnEnter(arg_6_0)
end

function var_0_0.OnExit(arg_7_0)
	var_0_0.super.OnExit(arg_7_0)
end

return var_0_0
