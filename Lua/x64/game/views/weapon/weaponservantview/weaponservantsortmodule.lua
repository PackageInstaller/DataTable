local var_0_0 = class("WeaponServantSortModule", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_servant/HeroServantSortUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnDispose(arg_6_0)
	arg_6_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:OnBackBtnClick()
	end)
end

function var_0_0.OnBackBtnClick(arg_9_0)
	arg_9_0:Back()
end

return var_0_0
