local var_0_0 = class("ActivityNewbieRebateIllustrateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activitynewbie/NewbieRechargeIllustrateUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnEnter(arg_3_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_7)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.layout_1)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBack_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
