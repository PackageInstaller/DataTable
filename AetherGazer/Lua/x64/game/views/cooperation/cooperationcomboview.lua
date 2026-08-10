local var_0_0 = class("CooperationComboView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdbuffUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_mask, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

return var_0_0
