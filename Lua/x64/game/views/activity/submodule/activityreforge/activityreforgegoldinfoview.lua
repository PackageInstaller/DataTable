local var_0_0 = class("ActivityReforgeGoldInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeGoldInfoUI"
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

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
