local var_0_0 = class("ActivityGodEaterLvUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_AFK/V4_2_GodEaterUI_AFK_LvUpPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()
end

function var_0_0.OnTop(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = arg_7_0.params_ and arg_7_0.params_.lastlV or 1
	local var_7_1 = arg_7_0.params_ and arg_7_0.params_.nowlV or 2
	local var_7_2 = ActivityGodEaterLevelCfg[var_7_0]
	local var_7_3 = ActivityGodEaterLevelCfg[var_7_1]

	if var_7_2 and var_7_3 then
		arg_7_0.levelnumText_.text = string.format("%s", var_7_1)
		arg_7_0.textdesc01Text_.text = GetTips("GODEATER_LV_DES_1")
		arg_7_0.textdesc02Text_.text = GetTips("GODEATER_LV_DES_2")
	end

	local var_7_4 = var_7_1 == GameSetting.godeater_subactivity_unlock1.value[1]

	SetActive(arg_7_0.tab03Go_, var_7_4)

	if var_7_4 then
		arg_7_0.textdesc03Text_.text = GetTips("GODEATER_DES_6")
	end
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgmaskBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0:StopTimer()
	arg_10_0:RemoveTween()
end

function var_0_0.RemoveTween(arg_11_0)
	return
end

function var_0_0.StopTimer(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
